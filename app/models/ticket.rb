class Ticket < ApplicationRecord
  has_many :details
  accepts_nested_attributes_for :details
  has_many :stored_employees,    through: :details
  has_many :retrieved_employees, through: :details
  validates :number, presence: true, length: { is: 6 }, uniqueness: true
  validates :name, presence: true
  before_save { self.name = name.upcase }
end
