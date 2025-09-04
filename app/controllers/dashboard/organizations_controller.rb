# frozen_string_literal: true

module Dashboard
  class OrganizationsController < DashboardController
  before_action :set_organization, only: %i[ show edit update destroy ]

  # GET /dashboard/organizations or /dashboard/organizations.json
  def index
    @organizations = Organization.all
  end

  # GET /dashboard/organizations/1 or /dashboard/organizations/1.json
  def show; end

  # GET /dashboard/organizations/new
  def new
    @organization = Organization.new
  end

  # GET /dashboard/organizations/1/edit
  def edit; end

  # POST /dashboard/organizations or /dashboard/organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to [ :dashboard, @organization ], notice: "Organization was successfully created." }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboard/organizations/1 or /dashboard/organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to [ :dashboard, @organization ], notice: "Organization was successfully updated." }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboard/organizations/1 or /dashboard/organizations/1.json
  def destroy
    @organization.destroy!

    respond_to do |format|
      format.html do
 redirect_to dashboard_organizations_path, status: :see_other, notice: "Organization was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def organization_params
      params.expect(organization: [ :name ])
    end
  end
end
