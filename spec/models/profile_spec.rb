require 'spec_helper'

describe Profile do
  before(:each) do
    @member    = FactoryGirl.build(:profile, :non_organizer, :approved)
    @organizer = FactoryGirl.build(:profile, :organizer, :approved)
    @blurb     = "This is my sample blurb is it is supposed to be about 80 characters in length..."
  end

  it "should differentiate organizers and non-organizers" do
    @member.should_not be_organizer
    @organizer.should  be_organizer
  end
  
  it "should leave the organizers sort order as is when saved" do
    @organizer.name       = "sample"
    @organizer.sort_order = 3
    @organizer.save_with_epic_sort

    @organizer.reload
    @organizer.sort_order.should be 3
  end

  it "should create a sort score based on the length of the blurb length" do
    @member.name       = "sample"
    @member.blurb      = @blurb
    @member.save_with_epic_sort

    @member.reload
    @member.sort_order.should be_between(0, 20)
  end

  it "should update attributes when saving with epic" do
    @member.save_with_epic_sort({blurb: @blurb, name: 'sample'})

    @member.reload
    @member.sort_order.should be_between(0, 20)
    @member.name.should == 'sample'
  end

  it "should resort all non-rganizer sort orders" do
    @member.name       = "sample"
    @member.blurb      = @blurb
    @member.save

    @member_2          = FactoryGirl.build(:profile, :non_organizer, :approved)
    @member_2.name     = "sample 2"
    @member_2.blurb    = @blurb
    @member_2.save

    Profile.resort_members!
    @member.reload
    @member_2.reload

    @member.sort_order.should   be_between(0, 20)
    @member_2.sort_order.should be_between(0, 20)
  end

end
