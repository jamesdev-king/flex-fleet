# frozen_string_literal: true

module Authenticateable
  extend ActiveSupport::Concern

  included do
    has_one :user, as: :authenticateable, touch: true
  end
end
