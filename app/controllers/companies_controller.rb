# frozen_string_literal: true

class CompaniesController < ApplicationController
  allow_unauthenticated_access
  before_action :set_company, only: %i[ show ]
  def show; end

    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params.expect(:id))
    end
end
