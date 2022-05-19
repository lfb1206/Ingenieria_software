# frozen_string_literal: true

class Turno < ApplicationRecord
  belongs_to :user
  has_many :requests, dependent: :destroy
  validates :cantidad_asientos,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 4 }
  validates :direccion_salida, presence: true, length: { minimum: 1 }
  validates :direccion_llegada, presence: true, length: { minimum: 1 }
  validates :dia_semana, presence: true, length: { minimum: 5, maximum: 9 }
  validates :tipo, presence: true, length: { minimum: 3, maximum: 6 }
  validates :hora_salida, presence: true
end
