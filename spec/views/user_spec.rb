require 'spec_helper'
require 'pp'

describe "Sign Up Page" do
  subject { page }

  describe "sign up" do
  	before { visit "/signup" }

  	describe "without filling any info" do
  	  before { click_button "create-acc" }
  	  it { should have_title('Sign Up') }
  	  it { should have_selector('div.panel-heading') }
  	  it { should have_selector('ul.list-group') }
  	end

  	describe "with valid information" do
  	  let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "user_fname", with: "TestFName"
        fill_in "user_lname", with: "TestLName"
        page.find("#user_gender_male").click
        fill_in "user_birthdate", with: "04/16/2014"
        fill_in "user_height", with: user.height
        fill_in "user_weight", with: user.weight
        fill_in "user_username", with: "TestFName" + rand(100000).to_s
        fill_in "user_email", with: "TestFName" + rand(100000).to_s + "@osu.edu"
        fill_in "user_password", with: user.password
        fill_in "user_password_confirmation", with: user.password_confirmation
        click_button "create-acc"
      end
      it { should_not have_title('Sign Up') }
      it { should_not have_selector('div.panel-heading') }
  	  it { should_not have_selector('ul.list-group') }
      #it { should have_title(user.fname) }
      #it { should have_link('My Profile', href: usernames_path(user.username)) }
      #it { should have_link('My Activity', href: show_day_path(user.username)) }
      #it { should have_link('My Calendar', href: calendar_path(user.username)) }
      #it { should have_link('My Exercise and Food', href: exercise_food_path(user.username)) }
      #it { should have_link('My Account Settings', href: settings_path(user.username)) }
      #it { should have_link('Sign Out', href: signout_path) }
      #it { should_not have_link('Sign in', href: signin_path) }
  	end
  end
end