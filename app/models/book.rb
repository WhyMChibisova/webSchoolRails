class Book < ApplicationRecord
  # string_enum :level, ['A1', 'A2', 'B1', 'B2', 'C1', 'C2']

  validates :name, :author, :language, :level, :description, presence: true
  validates :language, length: {minimum: 2}, format: {with: /\A[a-zA-Z]+\z/}
  validates :author, format: {with: /\A[a-zA-Z]+\z/}

  VALID_LEVELS = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'] # Use enums on database level
  validates :level, inclusion: {in: VALID_LEVELS}
end
