class ArticleLogics
  # Creates article from definition
  def self.create_or_update_from_definition(definition)
    begin
      article = Article.find_or_create_by_permalink(definition.id)
      article.title = definition.title
      article.content = definition.content
      article.date = definition.date
      article.permalink = definition.id
      article
    rescue
      nil # something goes wrong
    end
  end

  def self.publish(article)
    return false if article == nil

    article.save

    unless BlogArticle.exists?(:article_id => article.id)
      ba = BlogArticle.new()
      ba.article_id = article.id
      ba.save
    end
    
    true
  end

  def self.attach_to_project(article, project)
    project.articles << article unless project.articles.exists?(:permalink => article.permalink)
  end
end