# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations, id: :string do |t|
      t.string :name

      t.timestamps
    end
  end
end
