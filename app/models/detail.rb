class Detail < ApplicationRecord
  include AASM
  attr_accessor :s_employee_id, :r_employee_id
  belongs_to :ticket
  belongs_to :stored_employee, class_name: 'Employee',
              foreign_key: 'stored_employee_id', optional: true
  belongs_to :retrieved_employee, class_name: 'Employee',
              foreign_key: 'retrieved_employee_id', optional: true
  default_scope -> { order(created_at: :desc) }
  validates :amount, presence: true, length: { maximum: 3 }, numericality: { only_integer: true }, on: [:create, :edit]
  validates :location, presence: true, length: { maximum: 20 }, on: [:create, :edit]
  validates :room, inclusion: { in: ApplicationHelper::ROOMS }, :allow_nil => true, on: [:create, :edit, :update]
  validates :s_employee_id, inclusion:
          { in: Employee.where(active: true).pluck(:id_number).map!(&:to_s) }, on: [:create, :edit]
  validates :r_employee_id, inclusion:
          { in: Employee.where(active: true).pluck(:id_number).map!(&:to_s) }, on: :update
  before_save { self.location = location.upcase }
  before_save :store_employee
  before_update :store_employee
  before_update :retrieve_employee

  aasm do
    state :ST
    state :RNR
    state :LT
  end

  private

    def store_employee
      return unless stored_employee_id.nil?
      if s_employee_id
        self.stored_employee = Employee.find_by_id_number(s_employee_id)
      end
    end

    def retrieve_employee
      return unless retrieved_employee_id.nil?
      if r_employee_id
        self.retrieved_employee = Employee.find_by_id_number(r_employee_id)
      end
    end
end
