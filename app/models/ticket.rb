class Ticket < ApplicationRecord
  attr_accessor :r_employee_id
  validates :number, presence: true, length: { is: 6 }, uniqueness: true, on: :create
  validates :name, presence: true, length: { maximum: 25 }, on: :create
  has_many :details
  has_many :stored_employees,    through: :details
  has_many :retrieved_employees, through: :details
  accepts_nested_attributes_for :details
  before_save  { self.name = name.upcase }
  after_update :assign_active


  def latest_details
    self.details.first
  end

  def new_detail
    self.details.build
  end

  def latest_details_has_retrieved_employee?
    latest_details.retrieved_employee_id.present?
  end

  private

  def assign_active
    if active?
      if latest_details_retrieved_employee?
        update_attribute(:active, false)
      end
    else
      unless latest_details_retrieved_employee?
        update_attribute(:active, true)
      end
    end
  end
end
