class Detail < ApplicationRecord
  include AASM
  attr_accessor :s_employee_id, :r_employee_id, :relog
  belongs_to :ticket
  belongs_to :stored_employee, class_name: 'Employee',
              foreign_key: 'stored_employee_id', optional: true
  belongs_to :retrieved_employee, class_name: 'Employee',
              foreign_key: 'retrieved_employee_id', optional: true
  default_scope -> { order(created_at: :desc) }
  validates :amount, presence: true, length: { maximum: 2 }, numericality: { only_integer: true }
  validates :location, presence: true, length: { minimum: 2, maximum: 15 }
  validates :room, inclusion: { in: ApplicationHelper::Rooms }, :allow_nil => true
  validates :comment, length: { maximum: 40 }
  validates :s_employee_id, inclusion:
          { :in => lambda { |foo| foo.allowed_employees } }, on: [:create, :edit]
  validates :r_employee_id, inclusion:
          { :in => lambda { |foo| foo.allowed_employees } }, on: :update
  validates :aasm_state, inclusion: { in: ["ST", "RNR", "LT"] }
  before_save { self.location = location.upcase }
  before_save :store_employee
  before_save :remove_room_if_rnr
  before_update :store_employee
  before_update :retrieve_employee

  aasm do
    state :ST
    state :RNR
    state :LT
  end

  def allowed_employees
    Employee.where(active: true).pluck(:id_number).map!(&:to_s)
  end

  private

    def remove_room_if_rnr
      return if r_employee_id.present?
      if aasm_state == "RNR"
        self.room = nil
      end
    end

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
