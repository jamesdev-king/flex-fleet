# frozen_string_literal: true

module Dashboard
  class EmployeesController < DashboardController
  before_action :set_employee, only: %i[ show edit update destroy ]

  # GET /dashboard/employees or /dashboard/employees.json
  def index
    authorize(:employee)
    @employees = (Current.company || Current.organization).employees
  end

  # GET /dashboard/employees/1 or /dashboard/employees/1.json
  def show; end

  # GET /dashboard/employees/new
  def new
    # @employee = User.new(authenticateable: Employee.new).authenticateable
    @employee = Employee.new
  end

  # GET /dashboard/employees/1/edit
  def edit; end

  # POST /dashboard/employees or /dashboard/employees.json
  def create
    @user = User.new(user_params.merge(organization: Current.user.organization))
    @employee = Employee.new(employee_params)
    @employee.user = @user
    @user.authenticateable = @employee

    respond_to do |format|
      if @user.save
        format.html { redirect_to [ :dashboard, @employee ], notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors.merge(@user.errors), status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboard/employees/1 or /dashboard/employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        logger.debug "Updating employee #{@employee.company_employees.to_yaml}"
        format.html { redirect_to [ :dashboard, @employee ], notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboard/employees/1 or /dashboard/employees/1.json
  def destroy
    @employee.destroy!

    respond_to do |format|
      format.html do
 redirect_to dashboard_employees_path, status: :see_other, notice: "Employee was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: %i[email_address password])
    end

    def employee_params
      params.expect(employee: [ company_employees_attributes: [ %i[id company_id role _destroy] ] ])
    end
  end
end
