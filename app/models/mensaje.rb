class Mensaje < ApplicationRecord
  belongs_to :user
  belongs_to :turno
end
