class Detail < ApplicationRecord
  belongs_to :ticket
  belongs_to :stored_employee, class_name: 'Employee',
                               foreign_key: 'stored_employee_id', optional: true
  belongs_to :retrieved_employee, class_name: 'Employee',
                               foreign_key: 'stored_employee_id', optional: true
  default_scope -> { order(created_at: :desc) }

  # before_save :find_employee

  # def find_employee
  #   stored_employee = Employee.find_by(id_number: "385518")
  #   stored_employee = stored_employee.id
  # end
end
