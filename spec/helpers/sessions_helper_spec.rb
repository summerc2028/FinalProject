require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe SessionsHelper do

  subject { page }

# Integration Tests
  describe "on home page" do
    before { visit root_path }

    describe "for unsigned-in users" do
      it "should appear signed out" do
        expect(signed_in?).to be_false
      end

      it "should not return a current_user" do
        expect(current_user).to be_nil
      end
    end

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user, false
        visit root_path
      end

      it "should appear signed in" do
        expect(signed_in?).to be_true
      end

      it "should return the proper current_user" do
        expect(current_user).to equal user
      end

      it "should know which user is logged in" do
        expect(current_user? user).to be_true
      end
    end
  end

  describe "on sign in page" do
    let(:user) { FactoryGirl.create(:user, username: "administrator", password: "password", password_confirmation: "password") }
    # before { visit signin_path }

    describe "with invalid username" do
      # before do
      #   fill_in "Username", with: "username"
      #   fill_in "Password", with: "password"
      #   click_button "Sign In"
      # end
      # visit signin_path
      it { should have_content("Rememeber me") }
      it { should have_selector('div.alert.alert-danger') }
    end
  end
end
