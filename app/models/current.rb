# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :company
  attribute :organization
  delegate :user, to: :session, allow_nil: true
end
