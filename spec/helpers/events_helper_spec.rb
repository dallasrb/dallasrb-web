require 'spec_helper'

describe EventsHelper do
  describe "#should_display_rsvp?" do
    context "When an event is in the past" do
      subject { Event.new(:event_date => Date.yesterday)}
      it "should not display rsvp" do
        helper.should_display_rsvp?(subject).should be_false
      end
    end

    context "When an event has no rsvp_url" do
      subject { Event.new(:rsvp_url => nil)}
      it "should not display rsvp" do
        helper.should_display_rsvp?(subject).should be_false
      end
    end

    context "When an event has no rsvp_url and is in the past" do
      subject { Event.new(:rsvp_url => nil, :event_date => Date.yesterday)}
      it "should definitely not display rsvp" do
        helper.should_display_rsvp?(subject).should be_false
      end
    end
  end
end
