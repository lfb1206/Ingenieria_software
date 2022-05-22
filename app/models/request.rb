# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :user
  belongs_to :turno
  validates :descripcion, presence: true
end
