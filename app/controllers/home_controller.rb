class HomeController < ApplicationController
  # main page
  def index
    @articles = Article.all()
  end
end
