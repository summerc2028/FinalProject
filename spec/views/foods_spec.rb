require 'spec_helper'

describe "Food" do

  let(:user) { FactoryGirl.create(:user) }
  let(:food) { user.foods.create( name: "Sample Food", day: Date.current,
                    time: Time.current, calories: 100) }
  before do
    visit signin_path
    fill_in "username-primary", with: user.username
    fill_in "password-primary", with: user.password
    click_button "sign-in-primary"
  end

  subject { page }

  describe "single view" do
    before { visit show_food_path(username: user.username, id: food.id) }

    it { should have_title(food.name) }
    it { should have_content("My Food") }
    it { should have_content(food.name) }
    it { should have_content(food.calories) }
    it { should have_content(food.day.strftime("%B %e, %Y")) }
    # it { should have_content(food.time.strftime("%l:%M %p")) }

  end
end
