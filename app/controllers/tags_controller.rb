# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    render json: { tags: Project.tag_counts.most_used.map(&:name) }
  end
end
