class UpdateLogics
  def self.update_articles(git_path)
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
    Article.delete_all() # bad idea

    files = Dir.glob(path + "/*")
    files.each do |file|
      definition = File.read(file)
      article = ArticleLogics.create_from_definition(definition)
      article.save() if article != nil
    end
  end  
end