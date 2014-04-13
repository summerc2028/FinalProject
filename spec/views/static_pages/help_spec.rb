require 'spec_helper'

describe "Help page" do
  before { visit help_path }

  subject { page }

  it { should have_content('Help') }
  it { should have_title(full_title('Help')) }
end
