# frozen_string_literal: true

class Ride < ApplicationRecord
  belongs_to :customer
  belongs_to :company
  belongs_to :driver, class_name: "Employee", optional: true
end
