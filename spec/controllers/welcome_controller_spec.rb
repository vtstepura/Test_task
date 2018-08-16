require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #index' do

    context 'when user is logged in' do
      before do
        allow(controller).to receive(:current_user) { user }
        get :index
      end

      it 'renders the index template' do
        expect(response).to render_template('index')
      end

      it 'returns stasus 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when user is not logged in' do
      before { get :index }

      it 'redirects to login_path' do
        expect(response).to redirect_to(login_path)
      end

      it 'displays a success message' do
        expect(flash[:error]).to eql('Please authorize')
      end
    end
  end
end
