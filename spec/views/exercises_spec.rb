require 'spec_helper'

describe "Exercise" do

  let(:user) { FactoryGirl.create(:user) }
  let(:exercise) { user.exercises.create( name: "Sample Exercise", day: Date.current,
                    time: Time.current, calories: 100) }
  before do
    visit signin_path
    fill_in "username-primary", with: user.username
    fill_in "password-primary", with: user.password
    click_button "sign-in-primary"
  end

  subject { page }

  describe "single view" do
    before { visit show_exercise_path(username: user.username, id: exercise.id) }

    it { should have_title(exercise.name) }
    it { should have_content("My Exercise") }
    it { should have_content(exercise.name) }
    it { should have_content(exercise.calories) }
    it { should have_content(exercise.day.strftime("%B %e, %Y")) }
    # it { should have_content(exercise.time.strftime("%l:%M %p")) }

  end
end
