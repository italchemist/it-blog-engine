class ImagesController < ApplicationController
  def get
  	gitpath = Settings.git_path
    filename = params[:file]
    format = params[:format]
    send_data open("#{gitpath}/images/#{filename}.#{format}", "rb") { |f| f.read } 
  end
end