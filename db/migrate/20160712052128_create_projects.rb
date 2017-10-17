# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[4.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.string :description
      t.integer :favorites_count
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :projects, :slug, unique: true
  end
end
