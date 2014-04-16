require 'spec_helper'

describe Activity do

  before do
    @user = User.create( id: 1, fname: "John", lname: "Doe", username: "john-doe",
                      email: "test@example.com", gender: "Male",
                      birthdate: Date.current, height: 73, weight: 140,
                      status: "Hello", password: "password",
                      password_confirmation: "password", auth_token: "asdf1234")

    @activity = @user.activities.new( name: "Sample Activity", day: Date.current,
                      time: Time.current, length: "4:00",
                      location: "Sample Location")
  end

  subject { @activity }

  it { should respond_to(:name) }
  it { should respond_to(:day) }
  it { should respond_to(:time) }
  it { should respond_to(:length) }
  it { should respond_to(:location) }
  it { should respond_to(:user_id) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:user) }

  it { should be_valid }

  describe "when description is not present" do
    before { @activity.name = " " }
    it { should_not be_valid }
  end

  describe "when description is too long" do
    before { @activity.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when date is not present" do
    before { @activity.day = nil }
    it { should_not be_valid }
  end

  describe "when time is not present" do
    before { @activity.time = nil }
    it { should_not be_valid }
  end

  describe "when duration is not present" do
    before { @activity.length = " " }
    it { should_not be_valid }
  end

  describe "when duration format is invalid" do
    it "should be invalid" do
      times = %w[13 13:00:00 9:64 4:23PM 1: 1:1 :3 :34]
      times.each do |invalid_time|
        @activity.length = invalid_time
        expect(@activity).not_to be_valid
      end
    end
  end

  describe "when duration format is valid" do
    it "should be valid" do
      times = %w[1:00 1:23 100:00 1234:23 11:04 03:34 00:00]
      times.each do |valid_time|
        @activity.length = valid_time
        expect(@activity).to be_valid
      end
    end
  end

  describe "when location is not present" do
    before { @activity.location = " " }
    it { should_not be_valid }
  end

  describe "when location is too long" do
    before { @activity.location = "a" * 17 }
    it { should_not be_valid }
  end

  describe "when user_id references a nonexistent user" do
    before { @activity.user_id += 1 }
    it { should_not be_valid }
  end
end
