# frozen_string_literal: true

class CreateServiceAreas < ActiveRecord::Migration[8.0]
  def change
    create_table :service_areas, id: :string do |t|
      t.string :name
      t.geometry :boundary
      t.integer :status
      t.references :company, null: false, foreign_key: true, type: :string

      t.timestamps
    end
  end
end
