require 'spec_helper'
require 'rails_helper'

feature "Creating a goal" do
  context "when logged in" do
    before :each do
      sign_up_user
    end

    it "has a link to create new goal" do
      expect(page).to have_content "New Goal"
    end

    it "takes a content" do # t.text :content
      visit new_goal_path
      expect(page).to have_content "Content"
    end

    it "takes a title" do
      visit new_goal_path
      expect(page).to have_content "Title"
    end

    it "takes a privacy type" do
      visit new_goal_path
      expect(page).to have_content "private"
      expect(page).to have_content "public"
    end

    it "redirect to goal show page" do
      visit new_goal_path
      fill_in "Content", with: "Gotta work out"
      fill_in "Title", with: "Goal 1"
      choose("public")
      click_button "Create New Goal"
      expect(page).to have_content "Goal 1"
      expect(page).to have_content "Gotta work out"
      expect(page).to have_content "public"
    end

    it "validates the presence of content/title/privacy" do
      visit new_goal_path
      click_button "Create New Goal"
      expect(page).to have_content "Content can't be blank"
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Privacy can't be blank"
    end

  end

  context "when logged out" do # can't see any users' page
    it "redirects to log in page" do
      # create user with id = 1
      user = FactoryGirl.create(:user)
      goal = FactoryGirl.create(:goal)
      visit goal_url(goal)

      expect(page).to have_content "Log In"
    end
  end
end

feature "Editing a goal" do
  context "when logged in" do
    before :each do
      sign_up_user
      goal = FactoryGirl.create(:goal)
      visit goal_url(goal)
    end

    it "has a link to edit goal" do
      expect(page).to have_content "Edit Goal"
    end

    it "takes a content" do # t.text :content
      click_link "Edit Goal"
      expect(page).to have_content "Content"
    end

    it "takes a title" do
      click_link "Edit Goal"
      expect(page).to have_content "Title"
    end

    it "takes a privacy type" do
      click_link "Edit Goal"
      expect(page).to have_content "private"
      expect(page).to have_content "public"
    end

    it "redirect to goal show page" do
      click_link "Edit Goal"
      fill_in "Content", with: "Gotta work out"
      fill_in "Title", with: "Goal 1"
      choose("public")
      click_button "Update Goal"
      expect(page).to have_content "Goal 1"
      expect(page).to have_content "Gotta work out"
      expect(page).to have_content "public"
    end

    # it "validates the presence of content/title/privacy" do
    #   click_link "Edit Goal"
    #   click_button "Edit Goal"
    #   expect(page).to have_content "Content can't be blank"
    #   expect(page).to have_content "Title can't be blank"
    #   expect(page).to have_content "Privacy can't be blank"
    # end

    it "validates creator of goal" do
      goal = FactoryGirl.create(:goal)
      click_button "Log Out"
      sign_up("other user")
      visit goal_url(goal)
      expect(page).to_not have_content "Edit Goal"
    end
  end

  # context "when logged out" do # can't see any users' page
  #   it "redirects to log in page" do
  #     # create user with id = 1
  #     user = FactoryGirl.create(:user)
  #     goal = FactoryGirl.create(:goal)
  #     visit goal_url(goal)
  #
  #     expect(page).to have_content "Log In"
  #   end
  # end
end

feature "showing goals" do
  context "when logged in" do
    before :each do
      user1 = FactoryGirl.create(:user, id: 1)
      login(user1.username)
      goal1 = FactoryGirl.create(:goal)
      goal2 = FactoryGirl.create(:goal, privacy: "private", title: "private title")
      visit user_url(user1)
    end

    it "shows public goals" do
      expect(page).to have_content "goal's title"
    end

    it "shows private goals to creator" do
      expect(page).to have_content "private title"
    end

    it "doesn't allow others to see an user's private goals" do
      click_button "Log Out"
      user2 = FactoryGirl.create(:user, id: 2, username: "JP")
      login(user2.username)
      visit user_url(1)
      expect(page).to_not have_content "private title"
    end

    it "doesn't allow others to see private goal show page" do
      click_button "Log Out"
      user2 = FactoryGirl.create(:user, id: 2, username: "JP")
      login(user2.username)
      visit goal_url(2)
      expect(page).to_not have_content "private title"
    end

  end
end

feature "Deleting a goal" do
  context "when logged in" do
    before :each do
      sign_up_user
      @goal = FactoryGirl.create(:goal)
      visit goal_url(@goal)
    end

    it "has a button to delete goal" do
      expect(page).to have_button("Delete Goal")
    end

    it "redirect to user show page" do
      user = @goal.user
      visit goal_url(@goal)
      click_button "Delete Goal"
      expect(page).to_not have_content @goal.title
    end

    it "validates creator of goal" do
      click_button "Log Out"
      sign_up("other user")
      visit goal_url(@goal)
      expect(page).to_not have_button("Delete Goal")
    end
  end

end
