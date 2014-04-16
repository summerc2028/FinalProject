require 'spec_helper'

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
        choose('user_gender_male')
        fill_in "user_birthdate", with: "12/25/1990"
        fill_in "user_height", with: rand(100)
        fill_in "user_weight", with: rand(500)
        fill_in "user_username", with: "TestFName" + rand(100000).to_s
        fill_in "user_email", with: "TestFName" + rand(100000).to_s + "@osu.edu"
        fill_in "user_password", with: user.password
        fill_in "user_password_confirmation", with: user.password_confirmation
        click_button "create-acc"
      end
      it { should_not have_title('Sign Up') }
  	  it { should_not have_selector('ul.list-group') }
      it { should have_content('Good Day') }
      it { should have_link('Sign Out', href: signout_path) }
  	end
  end
end

describe "Account" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before do
  	visit signin_path
	fill_in "username-primary", with: user.username
    fill_in "password-primary", with: user.password
    click_button "sign-in-primary"
  end

  it { should have_title(user.fname) }

  describe "Profile" do
  	before { visit usernames_path(user.username) }

    it { should have_content(user.status) }
    it { should have_content(user.fname) }
    it { should have_content(user.lname) }
    it { should have_content(user.gender) }
    it { should have_content(user.weight) }
    it { should have_content(user.height) }
    it { should have_content("Today's Upcoming Activities") }
    it { should have_content("Health Information") }

  end

end