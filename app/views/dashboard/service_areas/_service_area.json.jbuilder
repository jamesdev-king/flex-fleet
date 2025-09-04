# frozen_string_literal: true

json.extract! service_area, :id, :name, :boundary, :status, :created_at, :updated_at
json.url service_area_url(service_area, format: :json)
