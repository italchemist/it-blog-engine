class ArticleController < InheritedResources::Base
  def resource
    @article = Article.find_by_permalink(params[:id])
  end
end
