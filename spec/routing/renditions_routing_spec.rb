require "rails_helper"

RSpec.describe RenditionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/renditions").to route_to("renditions#index")
    end

    it "routes to #show" do
      expect(get: "/renditions/1").to route_to("renditions#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/renditions").to route_to("renditions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/renditions/1").to route_to("renditions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/renditions/1").to route_to("renditions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/renditions/1").to route_to("renditions#destroy", id: "1")
    end
  end
end
