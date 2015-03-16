require 'spec_helper'
require 'rails_helper'

feature "Adding comments to users" do
  before :each do
    sign_up_user
  end

  it "there is an add comment from on the user show page" do
    expect(page).to have_content 'Add Comment'
  end

  it "validates presence of comment body" do
    click_button "Add Comment"
    expect(page).to have_content("Body can't be blank")
  end

  it "shows comment on user showpage" do
    fill_in "body", with: "This is a comment"
    click_button "Add Comment"
    expect(page).to have_content("This is a comment")
  end
end

feature "Adding comments to goals" do
  before :each do
    sign_up_user
    @goal = FactoryGirl.create(:goal)
  end

  it "there is an add comment from on the goal show page" do
    visit goal_url(@goal)
    expect(page).to have_content 'Add Comment'
  end

  it "validates presence of comment body" do
    visit goal_url(@goal)
    click_button "Add Comment"
    expect(page).to have_content("Body can't be blank")
  end

  it "shows comment on goal show page" do
    visit goal_url(@goal)
    fill_in "body", with: "This is a comment"
    click_button "Add Comment"
    expect(page).to have_content("This is a comment")
  end
end
