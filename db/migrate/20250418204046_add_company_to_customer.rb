# frozen_string_literal: true

class AddCompanyToCustomer < ActiveRecord::Migration[8.0]
  def change
    add_reference :customers, :company, null: false, foreign_key: true, type: :string
  end
end
