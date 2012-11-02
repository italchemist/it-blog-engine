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
    BlogArticle.delete_all()
    Article.delete_all() # bad idea
    Project.delete_all()

    files = Dir.glob(path + "/*")
    files.each do |file|
      ext = File.extname(file)
      definition = File.read(file)
      
      if ext == ".article"
        article = ArticleLogics.create_from_definition(definition)
        ArticleLogics.publish(article)
      elsif ext == ".project"
        pair = ProjectLogics.create_from_definition(definition)
        
        if pair != nil
          pair[:project].articles << pair[:article]
          pair[:project].save()
          pair[:article].save()
        end
      end

    end
  end  
end