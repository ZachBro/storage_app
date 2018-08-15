class Ticket < ApplicationRecord
  attr_accessor :r_employee_id
  has_many :details
  accepts_nested_attributes_for :details
  has_many :stored_employees,    through: :details
  has_many :retrieved_employees, through: :details
  validates :number, presence: true, length: { is: 6 }, uniqueness: true, on: :create
  validates :name, presence: true, on: :create
  before_save  { self.name = name.upcase }
  after_update :deactivate


    def latest_details
      self.details.first
    end

    def new_details
      self.details.build
    end

  private

    def deactivate
      if self.active == true
        if self.details.first.retrieved_employee_id.present?
          self.update_attribute(:active, false)
        end
      end
    end
end
