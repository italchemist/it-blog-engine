class ProjectsController < InheritedResources::Base
  def resource
    @project = Project.find_by_permalink(params[:id])
  end

  def collection
    @projects = Project.all()
  end  
end
