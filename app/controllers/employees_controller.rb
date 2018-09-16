class EmployeesController < ApplicationController
  before_action :set_employee,  only: [:show, :update]

  def index
    @employees = Employee.all
  end

  def show
  end

  def new
    redirect_to '/employees' unless logged_in?
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if logged_in? && @employee.save
      flash[:success] = "Successfully create employee #{@employee.id_number}"
      redirect_to '/employees'
    else
      render :action => 'new'
    end
  end

  def update
    @employee.assign_attributes(employee_params)
    if @employee.changed?
      if logged_in? && @employee.save
        flash[:success] = "Successfully updated employee #{@employee.id_number}"
        redirect_to '/employees'
      else
        render :action => "show"
      end
    else
      flash[:danger] = "No changes submitted"
      redirect_to @employee
    end
  end

  private

    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:id_number, :name)
    end
end
