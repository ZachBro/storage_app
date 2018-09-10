class EmployeesController < ApplicationController
  before_action :all_employees, only: [:index]
  before_action :one_employee,  only: [:show]


  private
    def one_employee
      @employee = Employee.find(params[:id])
    end

    def all_employees
      @employees = Employee.all
    end
end
