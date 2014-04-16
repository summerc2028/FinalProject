describe "Profile Page" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before do
  	visit signin_path
	fill_in "username-primary", with: user.username
    fill_in "password-primary", with: user.password
    click_button "sign-in-primary"
  end

  it { should have_title(user.fname) }

  describe "Profile" do
  	before { visit usernames_path(user.username) }

    it { should have_content(user.status) }
    it { should have_content(user.fname) }
    it { should have_content(user.lname) }
    it { should have_content(user.gender) }
    it { should have_content(user.weight) }
    it { should have_content(user.height) }
    it { should have_content("Today's Upcoming Activities") }
    it { should have_content("Health Information") }
  end
end