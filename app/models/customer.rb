# frozen_string_literal: true

class Customer < ApplicationRecord
  include Authenticateable
  include Caber::Subject
  include Caber::Object

  belongs_to :company
  has_many :rides, dependent: :nullify
  # has_one :acquisition_area, -> { rides.completed.first.service_area }
  # has_one :acquisition_company, -> { rides.completed.first.company }
end
