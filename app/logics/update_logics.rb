class UpdateLogics
  def self.update(git_path)
    fetch(git_path)
    process_definitions(git_path)
  end

  # Fetches articles from git repository.
  def self.fetch(git_path)
    git = Git.open(git_path)
    git.checkout
    git.fetch
    git.merge('origin/master')

    true # everything is ok.
  end

  # Processes all article definitions in the
  # specified directory. It creates new or
  # updates existing articles.
  def self.process_definitions(path)
    files = Dir.glob(path + "/*.project")
    files.each do |file|
      process_project(File.read(file))
    end

    files = Dir.glob(path + "/*.article")
    files.each do |file|
      process_article(File.read(file))
    end
  end

  private

  def self.process_article(definition)
    article_definition = ArticleDefinition.new(definition)
    article = ArticleLogics.create_or_update_from_definition(article_definition)
    
    if article_definition.publish_in_blog != "false"
      ArticleLogics.publish(article)
    end

    if article_definition.project_id != nil
      article.save
      project = Project.find_by_permalink(article_definition.project_id)
      ArticleLogics.attach_to_project(article, project) if project != nil
    end
  end

  def self.process_project(definition)
    project_definition = ProjectDefinition.new(definition)
    project = ProjectLogics.create_or_update_from_definition(project_definition)
    ProjectLogics.publish(project)
  end
end