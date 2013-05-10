require 'spec_helper'

describe HomeController do
  render_views

  describe "GET index" do
    it "returns http success" do
      meeting = FactoryGirl.create :event_type, :meeting
      FactoryGirl.create :event, :published, :event_type => meeting
      get :index
      response.should be_success
    end
  end

  describe "GET team" do
    it "returns http success" do
      FactoryGirl.create :profile, :organizer
      get :team
      response.should be_success
    end
  end
end
