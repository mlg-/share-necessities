class ThumbnailsController < ApplicationController
  def new
    @thumbnail = LinkThumbnailer.generate(params[:url])
    respond_to do |format|
      format.json { render json: @thumbnail }
    end
  end
end
