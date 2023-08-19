class Event < ApplicationRecord
  validates :name, :date, :time, :place, :language, :description, presence: true
  validates :language, length: {minimum: 2}, format: {with: /\A[a-zA-Z]+\z/}

end
