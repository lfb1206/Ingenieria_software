# frozen_string_literal: true

class Resena < ApplicationRecord
  belongs_to :user
  belongs_to :turno
  validates :calificacion,
            presence: {message: "escoge una calificación" },
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5, message: "escoge una calificación" }
end
