require 'rails_helper'

RSpec.describe StoresController, type: :controller do

    let(:valid_attributes) {
        { type: 'Store::LocalStore', name: 'Local Test Store', configuration: "{ base_path: 'test' }" }
    }

    let(:valid_session) { {} }

    before :each do
      request.headers["accept"] = 'application/json'
    end

    describe "GET #index" do
        it "returns a success response" do
            Store.create! valid_attributes
            get :index, params: {}, session: valid_session
            expect(response).to be_successful
        end
    end
end