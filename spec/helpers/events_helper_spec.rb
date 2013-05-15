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

    context "When an event has an rsvp_url and is happening today" do
      subject { Event.new(:rsvp_url => "http://plancast.com/test", :event_date => (Date.current)) }
      it "should display rsvp" do
        helper.should_display_rsvp?(subject).should be_true
      end
    end
  end
end
