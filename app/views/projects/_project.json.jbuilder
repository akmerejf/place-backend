# frozen_string_literal: true

json.call(project, :title,:image, :slug, :body, :created_at, :updated_at, :description, :tag_list)
json.author project.user, partial: 'profiles/profile', as: :user
json.favorited signed_in? ? current_user.favorited?(project) : false
json.favorites_count project.favorites_count || 0
