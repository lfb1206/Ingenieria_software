# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mensaje, type: :model do
  let(:mensaje) { create(:mensaje) }

  it 'is valid with valid attributes' do
    expect(mensaje).to be_valid
  end
end
