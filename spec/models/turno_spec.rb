# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Turno, type: :model do
  # Todo lo que está dentro de este bloque se ejecutará una vez antes de cada it
  before(:each) do
    # Creamos una instancia de la clase publicación "a mano", sin una factory
    @turno = Turno.new(title: 'A title', content: 'Content of the turno')
  end

  it 'is valid with valid attributes' do
    expect(@turno).to be_valid
  end

  it 'is not valid with no title' do
    @turno.title = nil
    expect(@turno).not_to be_valid
  end

  it 'is not valid with a title too short' do
    @turno.title = 'a'
    expect(@turno).not_to be_valid
  end

  it 'is not valid with no content' do
    @turno.content = nil
    expect(@turno).not_to be_valid
  end

  it 'is not valid with a content too short' do
    @turno.content = 'asd'
    expect(@turno).not_to be_valid
  end
end