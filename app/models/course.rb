class Course < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, :language, :level, :quantity_of_students, :age_of_group, :price, :description, presence: true
  validates :language, length: {minimum: 2}, format: {with: /\A[a-zA-Z]+\z/}
  validates :quantity_of_students, :age_of_group, numericality: {only_integer: true, greater_than: 0}
  validates :price, numericality: {greater_than: 0}

  VALID_LEVELS = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2']
  validates :level, inclusion: {in: VALID_LEVELS}
end
