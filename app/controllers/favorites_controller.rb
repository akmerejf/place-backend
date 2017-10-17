# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project!

  def create
    current_user.favorite(@project)

    render 'projects/show'
  end

  def destroy
    current_user.unfavorite(@project)

    render 'projects/show'
  end

  private

  def find_project!
    @project = Project.find_by!(slug: params[:project_slug])
  end
end
