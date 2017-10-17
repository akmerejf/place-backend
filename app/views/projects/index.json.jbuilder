# frozen_string_literal: true

json.projects do |json|
  json.array! @projects, partial: 'projects/project', as: :project
end

json.projects_count @projects_count
