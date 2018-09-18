class Ticket < ApplicationRecord
  include AASM
  attr_accessor :r_employee_id, :state_counter
  validates :number, presence: true, length: { is: 6 }, uniqueness: true
  validates :name,   presence: true, length: { maximum: 25 }
  has_many :details
  has_many :stored_employees,    through: :details
  has_many :retrieved_employees, through: :details
  accepts_nested_attributes_for :details
  before_save  { self.name = name.upcase }
  after_create :assign_current_state, unless: :state_counter
  after_update :assign_active
  after_update :assign_current_state, unless: :state_counter

  aasm do
    state :ST
    state :RNR
    state :LT
    state :Inactive
  end

  def latest_details
    details.first
  end

  def new_detail
    details.build
  end

  def latest_details_has_retrieved_employee?
    latest_details.retrieved_employee_id.present?
  end

  private

  def assign_active
    unless active == !latest_details_has_retrieved_employee?
      update_attribute(:active, !latest_details_has_retrieved_employee?)
    end
  end

  def assign_current_state
    self.state_counter = true
    if !active
      update_attribute(:aasm_state, "Inactive")
    else
      update_attribute(:aasm_state, latest_details.aasm_state)
    end
  end
end
