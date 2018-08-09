class Detail < ApplicationRecord
  attr_accessor :search_id
  belongs_to :ticket
  belongs_to :stored_employee, class_name: 'Employee',
                               foreign_key: 'stored_employee_id', optional: true
  belongs_to :retrieved_employee, class_name: 'Employee',
                               foreign_key: 'stored_employee_id', optional: true
  default_scope -> { order(created_at: :desc) }

  after_create :find_employee

  private

    def find_employee
      employee_test = Employee.find_by(id_number: @search_id)
      employee_test_id = employee_test.id
      self.update_attribute(:stored_employee_id, employee_test_id)
    end
end
