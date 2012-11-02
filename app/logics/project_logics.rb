class ProjectLogics
  # Creates project and article from definition
  # returns { :project, :article }
  def self.create_from_definition(definition)
    begin
      definition = ProjectDefinition.new(definition)
      project = Project.new()
      project.name = definition.name
      project.permalink = definition.id

      article = Article.new()
      article.title = project.name
      article.date = definition.date
      article.content = definition.content
      article.permalink = "#{definition.id}-overview"

      { :project => project, :article => article }
    rescue
      nil # something goes wrong
    end
  end
end