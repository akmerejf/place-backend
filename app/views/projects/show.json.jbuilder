# frozen_string_literal: true

json.project do |json|
  json.partial! 'projects/project', project: @project
end
