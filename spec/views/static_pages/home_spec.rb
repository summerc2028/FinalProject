require 'spec_helper'

describe "Home page" do
  before { visit root_path }

  subject { page }

  it { should have_content('Home') }
  it { should have_title full_title('') }
  it { should_not have_title('| Home') }

  describe "for signed-in users" do
    let(:user) { FactoryGirl.create(:user, username: "testuser", password: "password", password_confirmation: "password") }
    before do
      visit root_path
      first("button", "Sign In").click
      fill_in :username, with: "testuser"
      fill_in :password, with: "password"
      find('.modal-footer button').click
    end

    it "should render the account dropdown" do
      expect(page).to have_css('button[class="btn btn-default navbar-btn dropdown-toggle"]')
    end

    it "should not render a flash warning" do
      expect(page).not_to have_content "Invalid username or password"
    end
  end
end
