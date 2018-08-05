class Employee < ApplicationRecord
  has_many :stored_employees, class_name: 'Detail', foreign_key: 'id'
  has_many :retrieved_employees, class_name: 'Detail', foreign_key: 'id'
end
