require 'spec_helper'

describe ApplicationController do

	controller(ApplicationController) do
		def index
		end
	end

	describe "" do
		before(:each) do
			@admin = create(:admin)
			@request.env["devise.mapping"] = Devise.mappings[:admin]
		end

		context "when admin is logged in" do
			it "redirects admin to profile page" do
				get :index
				response.should redirect_to profile
			end
		end
	end

end

