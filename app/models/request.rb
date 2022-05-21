# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :user
  belongs_to :turno
  validates :description, presence: true
end
