# frozen_string_literal: true

class Mensaje < ApplicationRecord
  belongs_to :user
  belongs_to :turno
  validates :contenido, presence: true
end
