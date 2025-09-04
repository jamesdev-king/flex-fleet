# frozen_string_literal: true

module Dashboard
  class CompaniesController < DashboardController
  before_action :set_organization
  before_action :set_company, only: %i[ show edit update destroy ]

  # GET /dashboard/companies or /dashboard/companies.json
  def index
    @companies = Current.organization.companies
  end

  # GET /dashboard/companies/1 or /dashboard/companies/1.json
  def show; end

  # GET /dashboard/companies/new
  def new
    @company = @organization.companies.new
  end

  # GET /dashboard/companies/1/edit
  def edit; end

  # POST /dashboard/companies or /dashboard/companies.json
  def create
    @company = @organization.companies.new(company_params)
    authorize @company, :create?

    respond_to do |format|
      if @company.save
        format.html { redirect_to [ :dashboard, @company ], notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboard/companies/1 or /dashboard/companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to [ :dashboard, @company ], notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboard/companies/1 or /dashboard/companies/1.json
  def destroy
    @company.destroy!

    respond_to do |format|
      format.html do
 redirect_to dashboard_companies_path, status: :see_other, notice: "Company was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params.expect(:id))
    end

    def set_organization
      @organization = Organization.first
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.expect(company: [ :name ])
    end
  end
end
