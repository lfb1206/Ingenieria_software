# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :turnos, dependent: :destroy
  has_many :requests, dependent: :destroy
<<<<<<< HEAD
  has_many :resenas
=======
>>>>>>> feature/graphics
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { minimum: 3 }
  validates :address, presence: true
  validates :description, presence: true
  validates :phone, presence: true, length: { minimum: 8 }, numericality: { only_integer: true }
  validates :gender, presence: true
end
