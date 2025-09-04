# frozen_string_literal: true

class CreateRides < ActiveRecord::Migration[8.0]
  def change
    create_table :rides, id: :string do |t|
      t.references :customer, null: false, foreign_key: true, type: :string
      t.references :company, null: false, foreign_key: true, type: :string
      t.references :driver, foreign_key: { to_table: :employees }, type: :string
      t.json :origin_address, null: false
      t.st_point :origin_coordinate, null: false
      t.json :destination_address, null: false
      t.st_point :destination_coordinate, null: false
      t.integer :seats, null: false, default: 1
      t.json :estimates, null: false
      t.timestamp :requested_at
      t.timestamp :canceled_at
      t.timestamp :picked_up_at
      t.timestamp :completed_at

      t.timestamps
    end
  end
end
