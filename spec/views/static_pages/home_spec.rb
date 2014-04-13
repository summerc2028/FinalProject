require 'spec_helper'

describe "Home page" do
  before { visit root_path }

  subject { page }

  it { should have_content('Home') }
  it { should have_title full_title('') }
  it { should_not have_title('| Home') }

  it "should appear signed in" do
    expect(signed_in?).to be_false
  end

  it "should return a current_user" do
    expect(current_user).to be_nil
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

    it "should return a current_user" do
      expect(current_user).not_to be_nil
    end

    it "should render the account dropdown" do
      expect(page).to have_css('button[data-target="#sign-in-modal"]')#'button[class="btn btn-default navbar-btn dropdown-toggle"]')
    end
  end
end
