# frozen_string_literal: true

require 'rails_helper'
require 'factories/request'

RSpec.describe Request, type: :model do
  # Similar al before each, pero ahora usando los métodos let y create de FactoryBot
  # Además, usamos la factory de perfiles que definimos
  let(:request) { create(:request) }
  let(:second_request) { create(:request) }

  it 'is valid with valid attributes' do
    expect(request).to be_valid
  end
  
end
