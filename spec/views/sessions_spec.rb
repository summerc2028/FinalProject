require 'spec_helper'

describe "Sign in page" do

  subject { page }

  describe "signin" do
    before { visit signin_path }

    describe "with invalid credentials" do
      before { click_button "sign-in-primary" }

      it { should have_title('Sign In') }
      it { should have_selector('div.alert.alert-danger') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "username-primary", with: user.username
        fill_in "password-primary", with: user.password
        click_button "sign-in-primary"
      end

      it { should have_title(user.fname) }
      it { should have_link('My Profile', href: usernames_path(user.username)) }
      it { should have_link('My Activity', href: show_day_path(user.username)) }
      it { should have_link('My Calendar', href: calendar_path(user.username)) }
      it { should have_link('My Exercise and Food', href: exercise_food_path(user.username)) }
      it { should have_link('My Account Settings', href: settings_path(user.username)) }
      it { should have_link('Sign Out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign Out" }
        it { should have_button('Sign In') }
      end
    end
  end
end
