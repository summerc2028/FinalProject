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