class ProjectLogics
  # Creates project from definition
  def self.create_or_update_from_definition(definition)
    begin
      project = Project.find_or_create_by_permalink(definition.id)
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