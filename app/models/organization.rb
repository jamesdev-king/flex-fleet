# frozen_string_literal: true

class Organization < ApplicationRecord
  include Caber::Object
  has_many :companies
end
