# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :user
  belongs_to :turno
  validates :descripcion, presence: { message: 'agrega una dirección o descripción de tu solicitud' }
end
