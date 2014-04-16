require 'spec_helper'

describe "Activity" do

  let(:user) { FactoryGirl.create(:user) }
  let(:activity) { user.activities.create( name: "Sample Activity", day: Date.current,
                    time: Time.current, length: "4:00",
                    location: "Sample Location") }
  before do
    visit signin_path
    fill_in "username-primary", with: user.username
    fill_in "password-primary", with: user.password
    click_button "sign-in-primary"
  end

  subject { page }

  describe "single view" do
    before { visit show_activity_path(username: user.username, id: activity.id) }

    it { should have_title(activity.name) }
    it { should have_content("My Activity") }
    it { should have_content(activity.name) }
    it { should have_content(activity.location) }
    it { should have_content(activity.day.strftime("%B %e, %Y")) }
    # it { should have_content(activity.time.strftime("%l:%M %p")) }
    it { should have_content(activity.length) }

  end
end
