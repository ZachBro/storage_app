class Ticket < ApplicationRecord
  attr_accessor :r_employee_id, :assigning_active
  validates :number, presence: true, length: { is: 6 }, uniqueness: true, on: :create
  validates :name,   presence: true, length: { maximum: 25 }, on: :create
  has_many :details
  has_many :stored_employees,    through: :details
  has_many :retrieved_employees, through: :details
  accepts_nested_attributes_for :details
  before_save  { self.name = name.upcase }
  after_update :assign_active


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
end
