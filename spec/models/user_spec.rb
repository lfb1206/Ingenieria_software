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
  # validates :age, numericality: { greater_than_or_equal_to: 0 }

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

  it 'is not valid with a description too short' do
    user.description = 'asd'
    expect(user).not_to be_valid
  end

  it 'is not valid without an email' do
    user.email = nil
    expect(user).not_to be_valid
  end

  it 'is not valid with a repeated email' do
    user.email = second_user.email
    expect(user).not_to be_valid
  end

  it 'is not valid without age' do
    user.age = nil
    expect(user).not_to be_valid
  end

  it 'is not valid with a string age' do
    user.age = 'asd'
    expect(user).not_to be_valid
  end

  it 'is not valid with a negative age' do
    user.age = -1
    expect(user).not_to be_valid
  end

  describe 'summary' do
    it 'contains the name, the age and the work of the user' do
      expect(user.summary).to eq("#{user.name} - #{user.age} - #{user.work}")
    end
  end
end