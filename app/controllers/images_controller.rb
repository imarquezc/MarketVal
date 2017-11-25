class ImagesController < ApplicationController

    skip_before_action :verify_authenticity_token  

    def create
        image = Image.create(image: params[:image])
        if image.save
            respond_to do |format|
                msg = { :tags => ["tag1", "tag2"]}
                format.json  { render :json => msg } # don't do msg.to_json
              end
        else
            respond_to do |format|
                msg = { :error => "An error has occurred, please try again" }
                format.json  { render :json => msg } # don't do msg.to_json
              end
        end
    end

    def index
        images = Image.all
        respond_to do |format|
            msg = { :images => images}
            format.json  { render :json => msg } # don't do msg.to_json
          end
    end

    def show
        image = Image.find(params[:id])
        respond_to do |format|
            msg = { :image => image}
            format.json  { render :json => msg } # don't do msg.to_json
        end
    end

end
