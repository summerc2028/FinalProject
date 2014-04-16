require 'spec_helper'

describe "Sign in page" do

  subject { page }

  let(:user) { FactoryGirl.create(:user, username: "administrator", password: "password", password_confirmation: "passoword") }
  before { visit signin_path }

  it { should have_content("Sign In") }
  it { should have_content("Remember me") }

  describe "when username is invalid" do
    it "should display an error" do
      fill_in "username-primary", with: "invalid-name"
      fill_in "Password", with: "password"
      click_button "sign-in-primary"
      should have_selector('div.alert.alert-danger')
    end
  end
end
