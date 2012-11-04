class ProjectLogics
  # Creates project from definition
  def self.create_from_definition(definition)
    begin
      project = Project.new()
      project.name = definition.name
      project.permalink = definition.id

      project
    rescue
      nil # something goes wrong
    end
  end

  def self.publish(project)
    false if project == nil
    
    project.save
    
    true
  end  
end