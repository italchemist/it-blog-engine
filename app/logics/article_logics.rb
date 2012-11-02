class ArticleLogics
  # Creates article from definition
  def self.create_from_definition(definition)
    begin
      definition = ArticleDefinition.new(definition)
      article = Article.new()
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
    false if article == nil
    
    article.save

    ba = BlogArticle.new()
    ba.article_id = article.id
    ba.save
    
    true
  end
end