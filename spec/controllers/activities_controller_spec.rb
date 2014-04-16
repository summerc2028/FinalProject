require 'spec_helper'

# class ApplicationController < ActionController::Base
#     class AccessDenied < StandardError; end
#
#     rescue_from AccessDenied, :with => :access_denied
#
#     private
#     def access_denied
#         redirect_to "/401.html"
#     end
# end

describe ActivitiesController do

  let(:user) { FactoryGirl.create(:user) }
  let(:activity) { user.activities.create( name: "Sample Activity", day: Date.current,
                    time: Time.current, length: "4:00",
                    location: "Sample Location") }

  # controller do
  #   def index
  #     raise ApplicationController::AccessDenied
  #   end
  # end

  # describe "handling AccessDenied exceptions" do
  #     it "redirects to the /401.html page" do
  #       get :index
  #       expect(response).to redirect_to("/401.html")
  #   end
  # end


  describe "#new" do
      render_views
      it "renders the new view" do
        get :new, username: user.username
        response.should render_template :new
      end
  end

  describe "#create" do
      it "creates a new activity" do



      end
  end

  describe "#show" do
      it do

      end
  end

  describe "#destroy" do
      it do

      end
  end

  describe "#update" do
    it "responds to PUT" do
      put :update, username: user.username, :id => activity.id
      response.should be_success
    end

    it "requires the :id parameter" do
      expect { put :update }.to raise_error(ActionController::RoutingError)
    end
  end
end
