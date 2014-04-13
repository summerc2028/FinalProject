require 'spec_helper'

describe "Home page" do
  before { visit root_path }

  subject { page }

  it { should have_content('Home') }
  it { should have_title full_title('') }
  it { should_not have_title('| Home') }

  # describe "for signed-in users" do
  #   let(:user) { FactoryGirl.create(:user) }
  #   before do
  #     sign_in user
  #   end
  #
  #   it "should render the account dropdown" do
  #       it { should have_content("account") }
  #   end
  # end
end
