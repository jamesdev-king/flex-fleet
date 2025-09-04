# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  belongs_to :organization

  delegated_type :authenticateable, types: %w[Employee Customer]
  validates_associated :authenticateable
  accepts_nested_attributes_for :authenticateable

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
