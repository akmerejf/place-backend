# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :project, counter_cache: true
end
