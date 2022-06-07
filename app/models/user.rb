# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :turnos, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :resenas
  has_many :mensajes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: { message: 'agrega un nombre' },
                   length: { minimum: 3, message: 'tiene un minimo de 3 caracteres' }
  validates :address, presence: { message: 'agrega una dirección' }
  validates :description, presence: { message: 'agrega una descripción' }
  validates :phone, presence: { message: 'agrega un numero telefonico' },
                    length: { minimum: 8, message: 'ingresa un numero de 8 digitos' },
                    numericality: { only_integer: true, message: 'ingresa tan solo valores numericos' },
                    format: { with: /\A(2|9)[0-9]*\z/, message: 'tiene que comenzar con 2 o 9' }
  validates :gender, presence: { message: 'escoge un genero' }
end
