require 'rails_helper'

RSpec.describe EventsController, type: :controller do
    describe "Index successful" do
	   it "responds successfully with an HTTP 200 status code" do
	   	 get :index
	   	 expect(response).to be_success
	   	 expect(response).to have_http_status(200)
	   end

	   it "Make sure renders correct the index template" do
	   	 get :index
	   	 expect(response).to render_template("index")
	   end
	end

	describe "Edit functional" do
		it "user who created the event can edit the event" do
			user1 = User.new(name: "cuong", email: "cuong@gmail.com", password: "123")
			user2 = User.new(name: "teo", email: "teo@gmail.com", password: "123")
			user1.save
			user2.save
			event = Event.new(user_id: user1.id)
			event.save! validate: false
			allow(controller).to receive(:current_user) { user1 }
			get :edit, id: event.id
			expect(response).to render_template("edit")
		end
	end
end
