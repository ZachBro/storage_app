class Detail < ApplicationRecord
  attr_accessor :search_id
  belongs_to :ticket
  belongs_to :stored_employee, class_name: 'Employee',
              foreign_key: 'stored_employee_id', optional: true
  belongs_to :retrieved_employee, class_name: 'Employee',
              foreign_key: 'retrieved_employee_id', optional: true
  default_scope -> { order(created_at: :desc) }
  validates :amount, presence: true
  validates :location, presence: true
  validates :search_id, presence: true
  before_save { self.location = location.upcase }
  after_create :find_employee

  private

    def find_employee
      self.update_attribute(:stored_employee_id,
                            Employee.find_by(id_number: @search_id).id)
    end
end
