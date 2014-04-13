require 'spec_helper'

describe User do

  before do
    @user = User.new( fname: "John", lname: "Doe", username: "john-doe",
                      email: "test@example.com", gender: "Male",
                      birthdate: Date.current, height: 73, weight: 140,
                      status: "Hello", password: "password",
                      password_confirmation: "password", auth_token: "asdf1234")
  end

  subject { @user }

  it { should respond_to(:fname) }
  it { should respond_to(:lname) }
  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:gender) }
  it { should respond_to(:birthdate) }
  it { should respond_to(:height) }
  it { should respond_to(:weight) }
  it { should respond_to(:status) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:activities) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when first name is not present" do
    before { @user.fname = " " }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
    before { @user.lname = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when first name is too long" do
    before { @user.fname = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when last name is too long" do
    before { @user.lname = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @user.username = "a" * 17 }
    it { should_not be_valid }
  end

  describe "when username is too short" do
    before { @user.username = "a" * 4 }
    it { should_not be_valid }
  end

  describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.username = @user.username.upcase
      user_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when height is not present" do
    before { @user.height = nil }
    it { should be_valid }
  end

  describe "when height is not a number" do
    before { @user.height = "NaN" }
    it { should be_invalid }
  end

  describe "when height is not an integer" do
    before { @user.height = 1.1 }
    it { should be_invalid }
  end

  describe "when weight is not present" do
    before { @user.weight = nil }
    it { should be_valid }
  end

  describe "when weight is not a number" do
    before { @user.weight = "NaN" }
    it { should be_invalid }
  end

  describe "when weight is not an integer" do
    before { @user.weight = 1.1 }
    it { should be_invalid }
  end

  describe "when gender is not present" do
    before { @user.gender = nil }
    it { should be_valid }
  end

  describe "when gender is not 'Male' or 'Female'" do
    before { @user.gender = "Hello" }
    it { should be_invalid }
  end

  describe "when birthdate is not present" do
    before { @user.birthdate = nil }
    it { should be_valid }
  end

  describe "when birthdate is today" do
    before { @user.birthdate = Date.current }
    it { should be_valid }
  end

  describe "when birthdate is before today" do
    before { @user.birthdate = Date.current - 1 }
    it { should be_valid }
  end

  describe "when birthdate is after today" do
    before { @user.birthdate = Date.current + 1 }
    it { should be_invalid }
  end

  describe "when status is not present" do
    before { @user.status = nil }
    it { should be_valid }
  end

  describe "when status is too long" do
    before { @user.status = "a" * 141 }
    it { should be_invalid }
  end

  describe "when password is not present" do
    before do
      @user = User.new( fname: "John", lname: "Doe", username: "john-doe",
                        email: "test@example.com", gender: "Male",
                        birthdate: Date.current, height: 73, weight: 140,
                        status: "Hello", password: " ",
                        password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "auth token" do
    before { @user.save }
    its(:auth_token) { should_not be_blank }
  end

  describe "when auth token is already taken" do
    before do
      user_with_same_token = @user.dup
      user_with_same_token.auth_token = @user.auth_token.upcase
      user_with_same_token.save
    end

    it { should_not be_valid }
  end

  # describe "micropost associations" do
  #
  #   before { @user.save }
  #   let!(:older_micropost) do
  #     FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
  #   end
  #   let!(:newer_micropost) do
  #     FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
  #   end
  #
  #   it "should have the right microposts in the right order" do
  #     expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
  #   end
  #
  #   it "should destroy associated microposts" do
  #     microposts = @user.microposts.to_a
  #     @user.destroy
  #     expect(microposts).not_to be_empty
  #     microposts.each do |micropost|
  #       expect(Micropost.where(id: micropost.id)).to be_empty
  #     end
  #   end
  #
  #   describe "status" do
  #     let(:unfollowed_post) do
  #       FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
  #     end
  #     let(:followed_user) { FactoryGirl.create(:user) }
  #
  #     before do
  #       @user.follow!(followed_user)
  #       3.times { followed_user.microposts.create!(content: "Lorem ipsum") }
  #     end
  #
  #     its(:feed) { should include(newer_micropost) }
  #     its(:feed) { should include(older_micropost) }
  #     its(:feed) { should_not include(unfollowed_post) }
  #     its(:feed) do
  #       followed_user.microposts.each do |micropost|
  #         should include(micropost)
  #       end
  #     end
  #   end
  # end
end
