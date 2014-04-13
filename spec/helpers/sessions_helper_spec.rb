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
