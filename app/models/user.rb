class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :courses

  has_one_attached :avatar

  validates :name, :surname, :age, :login, presence: :true
  validates :login, uniqueness: true
  validates :password, confirmation: true
  validates :age, numericality: {only_integer: true, greater_than: 0}
  validates :name, :surname, format: {with: /\A[a-zA-Z]+\z/}

  enum role: %i[student teacher admin]
end
