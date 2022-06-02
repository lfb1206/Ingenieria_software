# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :user
  belongs_to :turno
  validates :descripcion,
            presence: { message: 'agrega una dirección o descripción de tu solicitud que tenga por lo menos 5 caracteres' }, length: { minimum: 5, message: 'tiene menos de 5 caracteres' }
  validates :estado, presence: { message: 'agrega un estado valido' }
end
