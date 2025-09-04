# frozen_string_literal: true

class ServiceArea < ApplicationRecord
  belongs_to :company

  enum :status, { inactive: 0, active: 1 }
end
