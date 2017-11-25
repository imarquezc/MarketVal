class ImagesController < ApplicationController

    skip_before_action :verify_authenticity_token  
    
    def create
        image = Image.new(image: params[:image])
        classification,tags = image.get_tags
        if image.save
            respond_to do |format|
                msg = { :tags =>tags , category: classification, image_id: image.id}
                format.json  { render :json => msg } # don't do msg.to_json
              end
        else
            respond_to do |format|
                msg = { :error => "An error has occurred, please try again" }
                format.json  { render :json => msg} # don't do msg.to_json
              end
        end
    end

    def index
        images = Image.all
        respond_to do |format|
            format.json  { render :json => images.to_json} # don't do msg.to_json
          end
    end

    def show
        image = Image.find(params[:id])
        respond_to do |format|
            format.json  { render :json => image.to_json } # don't do msg.to_json
        end
    end

end
