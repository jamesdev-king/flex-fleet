# frozen_string_literal: true

class CreateCompanyEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :company_employees, id: :string do |t|
      t.references :company, null: false, foreign_key: true, type: :string
      t.references :employee, null: false, foreign_key: true, type: :string
      t.integer :role, null: false, default: 0

      t.timestamps
    end
  end
end
