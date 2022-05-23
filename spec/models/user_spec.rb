# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # Similar al before each, pero ahora usando los métodos let y create de FactoryBot
  # Además, usamos la factory de perfiles que definimos
  let(:user) { create(:user) }
  let(:second_user) { create(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without name' do
    user.name = nil
    expect(user).not_to be_valid
  end

  it 'is not valid with a name too short' do
    user.name = 'a'
    expect(user).not_to be_valid
  end

  it 'is not valid without description' do
    user.description = nil
    expect(user).not_to be_valid
  end

  it 'is not valid without phone' do
    user.phone = nil
    expect(user).not_to be_valid
  end

  it 'is not valid with a string phone' do
    user.phone = 'asffs'
    expect(user).not_to be_valid
  end

  it 'is not valid without a gender' do
    user.gender = nil
    expect(user).not_to be_valid
  end

  it 'is not valid without a address' do
    user.address = nil
    expect(user).not_to be_valid
  end
end
