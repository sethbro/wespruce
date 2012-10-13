class ProjectsController < ApplicationController
  def index
    @projects = Project.open.page(params[:page])
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new(latitude: request.location.latitude, longitude: request.location.longitude)
  end

  def create
    @project = current_user.created_projects.new(project_params)
    @project.save ? redirect_to(project_path(@project)) : render(:new)
  end

private
  def project_params
    params[:project].permit(:name, :description, :rating, :latitude, :longitude)
  end
end
