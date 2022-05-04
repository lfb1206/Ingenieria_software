# frozen_string_literal: true

class Turno < ApplicationRecord
  validates :cantidad_asientos, presence: true, comparison: { greater_than_or_equal_to: 1,less_than_or_equal_to: 4}, numericality: { only_integer: true }
  validates :direccion_salida, presence: true
  validates :direccion_llegada, presence: true
  validates :dia_semana, presence: true, length: { minimum: 5, maximum: 9 }
  validates :tipo, presence: true, length: { minimum: 3, maximum: 6 }
end
