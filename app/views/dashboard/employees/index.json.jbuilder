# frozen_string_literal: true

json.array! @employees, partial: "dashboard/employees/employee", as: :employee
