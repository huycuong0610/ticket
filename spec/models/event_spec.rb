require 'rails_helper'

	let(:event) {event = Event.new}
  describe "#venue_name" do
  	it "return nil if there is no venue" do
  		expect(event.venue_name).to be_nil
  	end

  	it "returns venue name if there is a event" do
  		event.venue = Venue.new(name: "RMIT")
  		expect(event.venue_name).to eq "RMIT"
  	end
  end

  describe "#feature_events" do
    it "Past events should not be shown"  do
       event1, event2 = Event.new(starts_at: 1.day.ago), Event.new(starts_at: DateTime.now + 5.days)
       event1.save! validate: false
       event2.save! validate: false 
       expect(Event.feature_events).to eq [event2]
     end
  end 

  RSpec.describe Event, type: :model do
  describe ".upcoming" do
    it "return [] when there are no events" do
      expect(Event.upcoming).to eq []
    end
    it "return [] when there are only past events" do
      Event.create!(starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: " a past event",
                    venue: Venue.new, category: Category.new)
      expect(Event.upcoming).to eq []
    end
    it "return [b] when there are a past event 'a' and a future event 'b'" do
      a = Event.create!(name: "a", starts_at: 2.days.ago, ends_at: 1.day.ago, extended_html_description: "a past event",
                    venue: Venue.new, category: Category.new)
      b = Event.create!(name: "b", starts_at: 2.days.ago, ends_at: 1.day.from_now, extended_html_description: " a future event",
                    venue: Venue.new, category: Category.new)
      expect(Event.upcoming).to eq [b]
    end
  end

  describe "Event have at least one ticket type" do
    it "Event dont have ticket type" do
      event.publish = true
      event.save! validate: false
      expect(event.make_publish).to eq nil
    end
  end
end
