require 'spec_helper'

describe Profile do
  before(:each) do
    @member    = FactoryGirl.build(:profile, :non_organizer, :approved)
    @organizer = FactoryGirl.build(:profile, :organizer, :approved)
  end

  it "should differentiate organizers and non-organizers" do
    @member.should_not be_organizer
    @organizer.should  be_organizer
  end
  
  it "should leave the organizers sort order as is when saved" do
    @organizer.name       = "sample"
    @organizer.sort_order = 3
    @organizer.save

    @organizer.reload
    @organizer.sort_order.should be 3
  end

  it "should create a sort score based on the length of the blurb length" do
    @member.name       = "sample"
    @member.sort_order = 3
    @member.save!

    @member.reload
    @member.sort_order.should_not be 3

  end

end
