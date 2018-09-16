class Employee < ApplicationRecord
  has_many :stored_employees,    class_name: 'Detail', foreign_key: 'id'
  has_many :retrieved_employees, class_name: 'Detail', foreign_key: 'id'
  validates :id_number, presence: true, length: { is: 6 }, uniqueness: true
  validates :name, presence: true
  default_scope -> { order(id_number: :asc) }
end
