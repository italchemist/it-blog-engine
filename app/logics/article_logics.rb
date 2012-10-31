class ArticleLogics
  # Creates article from definition
  def self.create_from_definition(definition)
    begin
      definition = ArticleDefinition.new(definition)
      article = Article.new()
      article.title = definition.title
      article.content = definition.content
      article
    rescue
      puts "ERROR: " + definition
      nil # something goes wrong
    end
  end
end