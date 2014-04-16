require 'spec_helper'

describe ActivitiesController do

    describe "GET #new" do
        it "assigns a new Activity to @activity"
        Activity = Activity.new
        Activity.new.should == true
    end

    describe "POST #create" do
        context "with valid attributes" do
            it "saves the new activity in the database"
            it "redirects to the calendar page"
        end

        context "with invalid attributes" do
            it "does not save the new activity in the database"
            it "re-renders the :new template"
        end
    end

    describe "GET #index" do
        it "populates an array of activities"
        it "renders the :index view"
    end

    describe "GET #show" do
    it "assigns the requested activity to @activity"
    it "renders the :show template"
    end


end