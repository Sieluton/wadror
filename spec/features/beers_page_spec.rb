require 'rails_helper'
include Helpers

describe "Beer" do
  before :each do
    FactoryBot.create :brewery
    FactoryBot.create :user
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it 'when given name, is added to the system' do
    visit new_beer_path
    fill_in('beer_name', with:'testi')

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it 'when given invalid name, is not added to the system' do
    visit new_beer_path
    fill_in('beer_name', with:'')

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name can't be blank"
  end
end