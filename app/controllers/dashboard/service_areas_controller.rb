# frozen_string_literal: true

module Dashboard
  class ServiceAreasController < DashboardController
  before_action :set_service_area, only: %i[ show edit update destroy ]

  # GET /dashboard/service_areas or /dashboard/service_areas.json
  def index
    @service_areas = ServiceArea.all
  end

  # GET /dashboard/service_areas/1 or /dashboard/service_areas/1.json
  def show; end

  # GET /dashboard/service_areas/new
  def new
    @service_area = ServiceArea.new
  end

  # GET /dashboard/service_areas/1/edit
  def edit; end

  # POST /dashboard/service_areas or /dashboard/service_areas.json
  def create
    @service_area = ServiceArea.new(service_area_params)
    @service_area.company = Current.company

    respond_to do |format|
      if @service_area.save
        format.html { redirect_to [ :dashboard, @service_area ], notice: "Service area was successfully created." }
        format.json { render :show, status: :created, location: @service_area }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboard/service_areas/1 or /dashboard/service_areas/1.json
  def update
    respond_to do |format|
      if @service_area.update(service_area_params)
        format.html { redirect_to [ :dashboard, @service_area ], notice: "Service area was successfully updated." }
        format.json { render :show, status: :ok, location: @service_area }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @service_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboard/service_areas/1 or /dashboard/service_areas/1.json
  def destroy
    @service_area.destroy!

    respond_to do |format|
      format.html do
 redirect_to dashboard_service_areas_path, status: :see_other, notice: "Service area was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_service_area
      @service_area = ServiceArea.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def service_area_params
      params.expect(service_area: %i[name boundary status])
            .tap { |p| p[:boundary] = RGeo::GeoJSON.decode(p[:boundary]) }
    end
  end
end
