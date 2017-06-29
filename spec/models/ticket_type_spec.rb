require 'rails_helper'

RSpec.describe TicketType, type: :model do
   describe "multiple tickets with different price" do
  	it "handle one ticket type case" do
  	end

  	it "handle duplicates" do
  		event = Event.new(name: "Event")
  		event.save validate: false
  		type1 = event.ticket_types.create! price: 100
  		type2 = event.ticket_types.create! price: 120
  		expect(type2.errors[:base]).to eq ["Can not save duplicates"]
  	end
  end

  describe "can not buy more tickets than the quantity available" do

    it "The quantity over max quantity" do
      event = Event.new(name: "Event")
      event.save validate: false
      type = event.ticket_types.create price: 100, max_quantity: 30
      type.check_quantity(50)
      expect(type.errorsp[:base]).to eq ["Quantity can not great than max_quantity"]
    end
  end

  describe "can only buy up to 10 of a ticket type at a time" do
    it "the quantity can not great than 10" do
      event = Event.new(name: "Event")
      event.save validate: false
      type = event.ticket_types.create! price: 1.00, max_quantity: 10
      type.max_quantity_buy(11)
      expect(type.errors[:base]).to eq ["Quantity can not great than 10"]
    end
  end
end
