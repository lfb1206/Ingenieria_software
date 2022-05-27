# frozen_string_literal: true

class Turno < ApplicationRecord
  belongs_to :user
  has_many :requests, dependent: :destroy
  has_many :resenas
  has_many :mensajes
  validates :cantidad_asientos,
            presence: { message: 'agrega una dirección de salida' },
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 4,
                            message: 'agrega una cantidad de asientos disponibles entre 1 y 4' }
  validates :direccion_salida, presence: { message: 'agrega una dirección de salida' },
                               length: { minimum: 1, message: 'agrega una dirección de salida' }
  validates :direccion_llegada, presence: { message: 'agrega una dirección de llegada' },
                                length: { minimum: 1, message: 'agrega una dirección de llegada' }
  validates :dia_semana, presence: { message: 'agrega un día de la semana' }
  validates :tipo, presence: { message: 'agrega un tipo de turno' }
  validates :hora_salida, presence: true
end
