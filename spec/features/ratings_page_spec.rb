require 'rails_helper'
include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: user.username, password:"Foobar1")
  end

  it "lists the ratings and their total number" do
    @ratings = [10, 20, 30]
    @ratings.each do |rating_score|
      FactoryBot.create(:rating, score: rating_score, user: user)
    end
    visit ratings_path
    expect(page).to have_content "Amount of ratings #{@ratings.count}"
    @ratings.each do |ratings_score|
      expect(page).to have_content ratings_score
    end
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
end