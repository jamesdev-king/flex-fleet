# frozen_string_literal: true

class AddAuthenticateableToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :authenticateable, null: false, polymorphic: true, type: :string
  end
end
