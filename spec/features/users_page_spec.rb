require 'rails_helper'

include Helpers

describe "User" do
  let(:user) { FactoryBot.create :user }

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "should show all rating made by that user" do
    @ratings = [10, 20, 30]
    @ratings.each do |rating_score|
      FactoryBot.create(:rating, score: rating_score, user: user)
    end
    visit user_path(user)
    @ratings.each do |ratings_score|
      expect(page).to have_content ratings_score
    end
  end

  it "when user removes rating it is removed from the system" do
    FactoryBot.create(:rating, user: user)
    visit user_path(user)

    expect{
        find_link('delete').click
    }.to change{Rating.count}.from(1).to(0)
  end
end
