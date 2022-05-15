# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :users
  belongs_to :turnos
end
