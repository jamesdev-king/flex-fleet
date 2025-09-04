# frozen_string_literal: true

json.array! @companies, partial: "dashboard/companies/company", as: :company
