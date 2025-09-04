# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees, id: :string, &:timestamps
  end
end
