require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user, password: '123456') }

  describe 'GET #new' do
    before { get :new }

    it 'renders the new template' do
      expect(response).to render_template('new')
    end

    it 'returns stasus 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    before do
      user.update(role: role)
      post :create, params: { email: email, password: password }
    end

    context 'in case params are valid' do
      let(:email) { user.email }
      let(:password) { '123456' }

      context '#admin?' do
        let(:role) { :admin }

        it 'redirects to admin_users_path' do
          expect(response).to redirect_to(admin_users_path)
        end

        it 'displays a success message' do
          expect(flash[:success]).to eql('Successfully logged in!')
        end

        it { expect(session[:user_id]).to eql(user.id) }
      end

      context '#user?' do
        let(:role) { :user }

        it 'redirects to users_path' do
          expect(response).to redirect_to(users_path)
        end

        it 'displays a success message' do
          expect(flash[:success]).to eql('Successfully logged in!')
        end

        it { expect(session[:user_id]).to eql(user.id) }
      end
    end

    context 'in case params are valid' do
      let(:email) { user.email }
      let(:password) { '12345' }
      let(:role) { User.roles.keys.sample }

      it 'redirects to login_path' do
        expect(response).to redirect_to(login_path)
      end

      it 'displays a error message' do
        expect(flash[:error]).to eql('Check your email and password.')
      end
    end
  end

  describe 'DELETE #destroy' do
    before { session[:user_id] = user.id }

    it 'clears session' do
      expect { delete :destroy }
        .to change { session[:user_id] }.from(user.id).to(nil)
    end

    it 'redirects to login_path' do
      delete :destroy
      expect(response).to redirect_to(login_path)
    end

    it 'displays a success message' do
      delete :destroy
      expect(flash[:success]).to eql('Successfully logged out!')
    end
  end
end
