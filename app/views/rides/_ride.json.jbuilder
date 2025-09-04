# frozen_string_literal: true

json.extract! ride, :id, :customer_id, :company_id, :driver_id, :queried_at, :requested_at, :canceled_at,
              :picked_up_at, :completed_at, :origin_address, :origin_coordinate, :destination_address, :destination_coordinate, :estimates, :created_at, :updated_at
json.url ride_url(ride, format: :json)
