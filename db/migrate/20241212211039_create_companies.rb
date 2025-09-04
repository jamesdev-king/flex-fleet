# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies, id: :string do |t|
      t.references :organization, null: false, foreign_key: true, type: :string
      t.string :name

      t.timestamps
    end
  end
end
