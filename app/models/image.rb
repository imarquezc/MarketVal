class Image < ApplicationRecord
    belongs_to :product, optional: true


    require "base64"
    require 'net/http'

    uri = URI('https://brazilsouth.api.cognitive.microsoft.com/vision/v1.0/analyze')
    uri.query = URI.encode_www_form({
        'visualFeatures' => 'Categories,Tags',
        'language' => 'en'
    })

    def get_tags()
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
        return response.body
    end
end