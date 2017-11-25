class Image < ApplicationRecord
	belongs_to :product, optional: true
	has_many :tags


    require "base64"
	require 'net/http'
	require "JSON"

    

	def get_tags
		uri = URI('https://brazilsouth.api.cognitive.microsoft.com/vision/v1.0/analyze')
		uri.query = URI.encode_www_form({
			'visualFeatures' => 'Categories,Tags',
			'language' => 'en'
		})
        plain = Base64.decode64(self.image.partition(',').last)
        request = Net::HTTP::Post.new(uri.request_uri)
        # Request headers
        request['Content-Type'] = 'application/octet-stream'
        # Request headers
        request['Ocp-Apim-Subscription-Key'] = '6c99c2861bc7448395d807e7ee13e2fd'
        # Request body
        request.body = plain
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end
		json_response = JSON.parse(response.body)
		self.create_tags(json_response["tags"])
	end

	def create_tags(tags)
		classification = tags.present? ? tags[0]["name"] : ""
		created_tags = []
		if tags.present?
			tags.each do |tag|
				 (tag["confidence"] > 0.5) ? (created_tags << Tag.create!(name: tag["name"],image:self).name) : nil
			end
			
		end
		return classification,created_tags
	end
end