require 'spec_helper'

describe EventsHelper do
  describe "#should_display_rsvp?" do
    context "When an event is in the past" do
      let(:yesterday) { DateTime.parse('Mon, 29 Apr 2013 14:00:00 -05:00') }
      let(:today) { DateTime.parse('Tue, 30 Apr 2013 14:00:00 -05:00') }

      subject { Event.new(:event_date => yesterday)}
      it "should not display rsvp" do
        Timecop.freeze(today) do
          helper.should_display_rsvp?(subject).should be_false
        end
      end
    end

    context "When an event has no rsvp_url" do
      subject { Event.new(:rsvp_url => nil)}
      it "should not display rsvp" do
        helper.should_display_rsvp?(subject).should be_false
      end
    end

    context "When an event has no rsvp_url and is in the past" do
      let(:yesterday) { DateTime.parse('Mon, 29 Apr 2013 14:00:00 -05:00') }
      let(:today) { DateTime.parse('Tue, 30 Apr 2013 14:00:00 -05:00') }

      subject { Event.new(:rsvp_url => nil, :event_date => yesterday)}
      it "should definitely not display rsvp" do
        Timecop.freeze(today) do
          helper.should_display_rsvp?(subject).should be_false
        end
      end
    end

    context "When an event has an rsvp_url and is happening any time today" do
      let(:event_date) { DateTime.parse('Tue, 30 Apr 2013 14:00:00 -05:00') }
      let(:now) { DateTime.parse('Tue, 30 Apr 2013 18:00:00 -05:00') }

      subject { Event.new(:rsvp_url => "http://plancast.com/test", :event_date => event_date) }
      it "should display rsvp" do
        Timecop.freeze(now) do
          helper.should_display_rsvp?(subject).should be_true
        end
      end
    end
  end
end
