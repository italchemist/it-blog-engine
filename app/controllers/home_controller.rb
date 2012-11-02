class HomeController < ApplicationController
  # main page
  def index
    @articles = BlogArticle
      .all(:include => :article)
      .map{ |ba| ba.article }
      .sort_by{ |article| article.date }
      .reverse
  end
end
