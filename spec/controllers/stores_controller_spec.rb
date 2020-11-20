require 'rails_helper'

RSpec.describe StoresController, type: :controller do
    describe "Stores API", type: :request do
      describe 'GET /api/stores' do
        before do
          FactoryBot.create(:store, name: 'Local Store', type: 'Store::LocalStore', configuration: { base_path: 'test' }.to_json )
        end

        it 'returns all stores' do
          get '/api/stores', as: :json

          expect(response).to have_http_status(:success)
        end
      end

      describe 'POST /api/stores/local' do
        it 'creates a new local store' do
          expect {
            post '/api/stores/local',
              params: {
                name: 'Local Store',
                configuration: { base_path: 'test' }
              },
              as: :json
          }.to change { Store.count }.from(0).to(1)
        end
      end

      describe 'DELETE /api/stores/:id' do
        let!(:store) { FactoryBot.create(:store, name: 'Local Store', type: 'Store::LocalStore', configuration: { base_path: 'test' }.to_json ) }

        it 'deletes a store' do
          expect {
            delete "/api/stores/#{store.id}", as: :json
          }.to change { Store.count }.from(1).to(0)

          expect(response).to have_http_status(:no_content)
        end
      end
    end
end