# frozen_string_literal: true

class AddOrganizationToUser < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :organization, null: false, foreign_key: true, type: :string
  end
end
