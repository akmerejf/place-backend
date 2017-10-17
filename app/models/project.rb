# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :authored_by, ->(username) { where(user: User.where(username: username)) }
  scope :favorited_by, ->(username) { joins(:favorites).where(favorites: { user: User.where(username: username) }) }

  acts_as_taggable
  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/rickmorty404thumb.png"
  validates_attachment :picture, presence: true
  do_not_validate_attachment_file_type :picture
  validates :title, presence: true, allow_blank: false
  validates :body, presence: true, allow_blank: false
  validates :slug, uniqueness: true, exclusion: { in: ['feed'] }

  # has_many :projects, dependent: :destroy

  before_validation do
    self.slug ||= "#{title.to_s.parameterize}-#{rand(36**6).to_s(36)}"
  end
end
