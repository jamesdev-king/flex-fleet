# frozen_string_literal: true

class RidesController < ApplicationController
  before_action :set_ride, only: %i[ show edit update destroy ]

  # GET /rides or /rides.json
  def index
    @rides = Current.user.authenticateable.rides.where(company_id: @company.id)
  end

  # GET /rides/1 or /rides/1.json
  def show; end

  # GET /rides/new
  def new
    @ride = Ride.new
  end

  # GET /rides/1/edit
  def edit; end

  # POST /rides or /rides.json
  def create
    @ride = Ride.new(ride_params)
    @ride.company = @company
    @ride.customer = Current.user.authenticateable

    respond_to do |format|
      if @ride.save
        format.html { redirect_to [ @company, @ride ], notice: "Ride was successfully created." }
        format.json { render :show, status: :created, location: @ride }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rides/1 or /rides/1.json
  def update
    respond_to do |format|
      if @ride.update(ride_params)
        format.html { redirect_to [ @company, @ride ], notice: "Ride was successfully updated." }
        format.json { render :show, status: :ok, location: @ride }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rides/1 or /rides/1.json
  def destroy
    @ride.destroy!

    respond_to do |format|
      format.html do
 redirect_to company_rides_path(@company), status: :see_other, notice: "Ride was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

    def set_ride
      @ride = Ride.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def ride_params
      params.expect(ride: %i[
                      origin_address origin_coordinate
                      destination_address destination_coordinate
                    ]).tap do |p|
        p[:origin_coordinate] = RGeo::GeoJSON.decode(p[:origin_coordinate])
        p[:destination_coordinate] = RGeo::GeoJSON.decode(p[:destination_coordinate])
        p[:estimates] = {}
      end
    end
end
