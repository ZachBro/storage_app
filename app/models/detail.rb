class Detail < ApplicationRecord
  attr_accessor :s_employee_id, :r_employee_id
  belongs_to :ticket
  belongs_to :stored_employee, class_name: 'Employee',
              foreign_key: 'stored_employee_id', optional: true
  belongs_to :retrieved_employee, class_name: 'Employee',
              foreign_key: 'retrieved_employee_id', optional: true
  default_scope -> { order(created_at: :desc) }
  validates :amount, :location, presence: true, on: [:create, :edit]
  validates :s_employee_id, inclusion:
          { in: Employee.where(active: true).pluck(:id_number).map!(&:to_s) }, on: [:create, :edit]
  validates :r_employee_id, inclusion:
          { in: Employee.where(active: true).pluck(:id_number).map!(&:to_s) }, on: :update
  before_save { self.location = location.upcase }
  after_create :store_employee
  after_update :store_employee
  after_update :retrieve_employee



  private

    def store_employee
      if self.stored_employee_id.nil?
        if @s_employee_id
          self.update_attribute(:stored_employee_id,
                                Employee.find_by(id_number: @s_employee_id).id)
        end
      end
    end

    def retrieve_employee
      if self.retrieved_employee_id.nil?
        if @r_employee_id
          self.update_attribute(:retrieved_employee_id,
                                Employee.find_by(id_number: @r_employee_id).id)
        end
      end
    end
end
