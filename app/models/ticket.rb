class Ticket < ApplicationRecord
  attr_accessor :r_employee_id
  validates :number, presence: true, length: { is: 6 }, uniqueness: true, on: :create
  validates :name, presence: true, length: { maximum: 25 }, on: :create
  has_many :details
  has_many :stored_employees,    through: :details
  has_many :retrieved_employees, through: :details
  accepts_nested_attributes_for :details
  before_save  { self.name = name.upcase }
  after_update :toggle_active


    def latest_details
      self.details.first
    end

    def new_detail
      self.details.build
    end

  private

  def toggle_active
    if self.active == true
      if self.details.first.retrieved_employee_id.present?
        self.update_attribute(:active, false)
      end
    elsif self.active == false
      if self.details.first.retrieved_employee_id.blank?
        self.update_attribute(:active, true)
      end
    end
  end
end
