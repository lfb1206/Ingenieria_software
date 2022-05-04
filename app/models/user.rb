# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { minimum: 1, maximum: 4}
  validates :address, presence: true
  validates :description, presence: true
  validates :phone, presence: true, length: { minimum: 8 }
  validates :gender, presence: true
end
