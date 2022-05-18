# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Turno, type: :model do
  # Todo lo que está dentro de este bloque se ejecutará una vez antes de cada it
  # let(:turno) { create(:turno) }
  before(:each) do
    @attr_user = {
      id_usuario: Faker::Number.between(from: 1, to: 10_000),
      cantidad_asientos: Faker::Number.between(from: 1, to: 4),
      hora_salida: '13:50',
      direccion_salida: Faker::Address.full_address,
      direccion_llegada: Faker::Address.full_address,
      dia_semana: %w[Lunes Martes Miércoles Jueves Viernes Sabado].sample,
      tipo: %w[Ida Vuelta].sample,
      estado: %w[ACTIVO CONFIRMADO COMPLETADO].sample
    }
    @turno = Turno.create!(@attr_user)
  end

  it 'is valid with valid attributes' do
    expect(@turno).to be_valid
  end

  it 'is not valid with no sits' do
    @turno.cantidad_asientos = nil
    expect(@turno).not_to be_valid
  end

  it 'is not valid with a string instead of a numbre' do
    @turno.cantidad_asientos = 'aaa'
    expect(@turno).not_to be_valid
  end

  it 'is not valid with not time of start' do
    @turno.hora_salida = nil
    expect(@turno).not_to be_valid
  end

  it 'is not valid with no inicial address ' do
    @turno.direccion_salida = nil
    expect(@turno).not_to be_valid
  end

  it 'is not valid with no final address ' do
    @turno.direccion_llegada = nil
    expect(@turno).not_to be_valid
  end

  it 'is not valid with no day of the week ' do
    @turno.dia_semana = nil
    expect(@turno).not_to be_valid
  end

  it 'is not valid with no inicial address ' do
    @turno.direccion_llegada = nil
    expect(@turno).not_to be_valid
  end

  it 'is not valid with no type' do
    @turno.tipo = nil
    expect(@turno).not_to be_valid
  end
end
