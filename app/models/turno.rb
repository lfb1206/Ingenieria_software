# frozen_string_literal: true

class Turno < ApplicationRecord
  validates :name, length: { minimum: 2 }
  validates :description, length: { minimum: 5 }
  validates :email, presence: true, uniqueness: true
  validates :age, numericality: { greater_than_or_equal_to: 0 }
  validates :cantidad_asientos, presence: true, length: { minimum: 1, maximum: 1 }
  validates :direccion_salida, presence: true
  validates :direccion_llegada, presence: true
  validates :dia_semana, presence: true, length: { minimum: 5, maximum: 9 }
  validates :tipo, presence: true, length: { minimum: 3, maximum: 6 }
end
