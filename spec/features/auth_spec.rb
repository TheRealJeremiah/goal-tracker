require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit "/users/new"
  end

  it "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      # sign up,
      fill_in 'Username', with: 'my_username'
      fill_in 'Password', with: 'my_password'
      click_button 'Sign Up'
      expect(page).to have_content 'my_username'
    end

  end

end

feature "logging in" do

  it "shows username on the homepage after login" do
    sign_up_user
    click_button 'Log Out'
    visit "/session/new"
    fill_in 'Username', with: 'my_username'
    fill_in 'Password', with: 'my_password'
    click_button 'Log In'
    expect(page).to have_content 'my_username'
  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit "/session/new"
    expect(page).to have_content "Log In"
  end

  it "doesn't show username on the homepage after logout" do
    sign_up_user
    click_button 'Log Out'
    expect(page).to_not have_content 'my_username'
  end

end
