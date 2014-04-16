require 'spec_helper'

class ApplicationController < ActionController::Base
    class AccessDenied < StandardError; end

    rescue_from AccessDenied, :with => :access_denied

    private
    def access_denied
        redirect_to "/401.html"
    end
end

describe ApplicationController do
  controller do
    def index
      raise ApplicationController::AccessDenied
  end
end

describe "handling AccessDenied exceptions" do
    it "redirects to the /401.html page" do
      get :index
      expect(response).to redirect_to("/401.html")
  end
end

describe "#create" do 
    it "creates a new activity" do
    


    end
end

describe "#show" do
    it 

    end
end

describe "#destroy" do
    it 

    end
end


describe "#new" do
    it 

    end
end

describe "#update" do
    it 

    end
end



end