# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @projects = Project.all.includes(:user)

    @projects = @projects.tagged_with(params[:tag]) if params[:tag].present?
    @projects = @projects.authored_by(params[:author]) if params[:author].present?
    @projects = @projects.favorited_by(params[:favorited]) if params[:favorited].present?

    @projects_count = @projects.count

    @projects = @projects.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)
  end

  def feed
    @projects = Project.includes(:user).where(user: current_user.following_users)

    @projects_count = @projects.count

    @projects = @projects.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)

    render :index
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      render :show
    else
      render json: { errors: @project.errors }, status: :unprocessable_entity
    end
  end

  def show
    @project = Project.find_by!(slug: params[:slug])
  end

  def update
    @project = Project.find_by!(slug: params[:slug])

    if @project.user_id == @current_user_id
      @project.update_attributes(project_params)

      render :show
    else
      render json: { errors: { project: ['not owned by user'] } }, status: :forbidden
    end
  end

  def destroy
    @project = Project.find_by!(slug: params[:slug])

    if @project.user_id == @current_user_id
      @project.destroy

      render json: {}
    else
      render json: { errors: { project: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :body, :description, :picture, tag_list: [])
  end
end
