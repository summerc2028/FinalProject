require 'spec_helper'

describe Food do

  before do
    @user = User.create( id: 1, fname: "John", lname: "Doe", username: "john-doe",
                      email: "test@example.com", gender: "Male",
                      birthdate: Date.current, height: 73, weight: 140,
                      status: "Hello", password: "password",
                      password_confirmation: "password", auth_token: "asdf1234")

    @food = @user.foods.new( name: "Sample Exercise", day: Date.current,
                      time: Time.current, calories: "400")
  end

  subject { @food }

  it { should respond_to(:name) }
  it { should respond_to(:day) }
  it { should respond_to(:time) }
  it { should respond_to(:calories) }
  it { should respond_to(:user_id) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:user) }

  it { should be_valid }

  describe "when description is not present" do
    before { @food.name = " " }
    it { should_not be_valid }
  end

  describe "when description is too long" do
    before { @food.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when date is not present" do
    before { @food.day = nil }
    it { should_not be_valid }
  end

  describe "when time is not present" do
    before { @food.time = nil }
    it { should_not be_valid }
  end

  describe "when calories is not present" do
    before { @food.calories = nil }
    it { should_not be_valid }
  end

  describe "when user_id references a nonexistent user" do
    before { @food.user_id += 1 }
    it { should_not be_valid }
  end
end
