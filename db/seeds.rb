# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

AdminUser.create!(email: 'grupo48@uc.cl', password: 'grupo48', password_confirmation: 'grupo48') if Rails.env.development?

#Seed para los users
User.destroy_all

15.times do |index|
  User.create!(
    foto: "https://images.pexels.com/photos/1987049/pexels-photo-1987049.jpeg", 
    email: Faker::Internet.safe_email,
    password: 'password',
    password_confirmation: 'password',
    name: Faker::Name.name,
    address: Faker::Address.full_address, 
    description: Faker::Lorem.sentence, 
    gender: Faker::Gender.binary_type, 
    phone: %w[2 9].sample + (Faker::Number.between(from: 1_000_000, to: 9_999_999)).to_s, 
    reglas: Faker::Lorem.sentence)
end

p "Created #{User.count} users"



#Seed para los turnos
Turno.destroy_all
user_all = User.all

15.times do |index|
  Turno.create!(
    cantidad_asientos: Faker::Number.between(from: 1, to: 4),
    hora_salida: Time.now,
    direccion_salida: Faker::Address.full_address,
    direccion_llegada: Faker::Address.full_address,
    dia_semana: %w[Lunes Martes Miércoles Jueves Viernes Sabado].sample,
    tipo: %w[Ida Vuelta].sample,
    espacio: %w[Solo_mochilas Proyecto_de_tamaño_mediano Maqueta_grande].sample,
    estado: %w[ACTIVO CONFIRMADO COMPLETADO].sample,
    user_id: user_all.sample(1).id) ##Falta ver como hacer las asociaciones
    end

p "Created #{Turno.count} turnos"

'''
#Seed para los reseñas
Resenas.destroy_all

15.times do |index|
  Resenas.create!(
    contenido: Faker::Lorem.sentence,
    calificacion: Faker::Number.between(from: 0, to: 5),
    association :user, factory: :user
    association :turno, factory: :turno) ##Falta ver como hacer las asociaciones
    end

p "Created #{Resenas.count} resenas"


#Seed para los requests
Request.destroy_all

15.times do |index|
  Request.create!(
    descripcion: Faker::Lorem.sentence,
    estado: %w[ACEPTADO RECHAZADO PENDIENTE].sample,
    association :user, factory: :user
    association :turno, factory: :turno) ##Falta ver como hacer las asociaciones
    end

p "Created #{Request.count} request"

#Seed para los mensajes
Mensaje.destroy_all

15.times do |index|
  Mensaje.create!(
    contenido: Faker::Lorem.sentence,
    association :user, factory: :user
    association :turno, factory: :turno) ##Falta ver como hacer las asociaciones
    end

p "Created #{Mensaje.count} mensaje"
'''