# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resena, type: :model do
  # Similar al before each, pero ahora usando los métodos let y create de FactoryBot
  # Además, usamos la factory de perfiles que definimos
  before(:each) do
    @user = FactoryBot.create(:user)
    @turno = FactoryBot.create(:turno)
    @resena = FactoryBot.create(:resena)
    @resena.calificacion = @resena.calificacion.to_i
  end

  it 'is valid with valid attributes' do
    expect(@resena).to be_valid
  end

  it 'is not valid with no sits' do
    @resena.calificacion = nil
    expect(@resena).not_to be_valid
  end

  it 'is not valid with a string instead of a numbre' do
    @resena.calificacion = 'aaa'
    expect(@resena).not_to be_valid
  end

  it 'is not valid with not time of start' do
    @resena.calificacion = 6
    expect(@resena).not_to be_valid
  end

  it 'is not valid with no inicial address ' do
    @resena.calificacion = -1
    expect(@resena).not_to be_valid
  end
end
