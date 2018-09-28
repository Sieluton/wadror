require 'rails_helper'

RSpec.describe Beer, type: :model do
  it 'has been made correctly' do
    breweryTest = Brewery.new name: "test", year: 2000
    beerTest = Beer.new name:"test", style:"testStyle", brewery:breweryTest

    expect(beerTest.name).to eq("test")
    expect(beerTest.style).to eq("testStyle")
    expect(beerTest.brewery).to eq(breweryTest)
  end

  it 'is saved' do
    breweryTest = Brewery.new name: "test", year: 2000
    beerTest = Beer.create name:"test", style:"testStyle", brewery:breweryTest

    expect(beerTest).to be_valid
    expect(Beer.count).to eq(1)
  end

  it 'is not saved without name' do
    breweryTest = Brewery.new name: "test", year: 2000
    beerTest = Beer.create style:"testStyle", brewery:breweryTest

    expect(beerTest).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it 'is not saved without style' do
    breweryTest = Brewery.new name: "test", year: 2000
    beerTest = Beer.create name:"test", brewery:breweryTest

    expect(beerTest).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
