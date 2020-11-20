require 'rails_helper'

RSpec.describe StoresController, type: :controller do
    describe "Stores API", type: :request do
      it 'returns all stores' do
        FactoryBot.create(:store, name: 'Local Store', type: 'Store::LocalStore', configuration: { base_path: 'test' } )

        get '/api/stores', as: :json

        expect(response).to have_http_status(:success)
      end
    end
end