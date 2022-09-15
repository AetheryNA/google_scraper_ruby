# frozen_string_literal: true

require 'rails_helper'
require 'ffaker'

RSpec.describe RegisterController, type: :controller do
  describe 'GET#index' do
    it 'returns a successful response' do
      get :index

      expect(response).to be_successful
    end
  end

  describe 'POST#create' do
    context 'given valid data' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: { username: 'testusername', password: 'password', password_confirmation: 'password' } }
        end.to change(User, :count).by(1)
      end

      it 'redirects the user to the Home page' do
        post :create, params: { user: { username: 'testusername', password: 'password', password_confirmation: 'password' } }

        expect(response).to redirect_to(root_path)
      end
    end

    context 'given invalid data' do
      it 'does not create a new user if the username is nil' do
        expect do
          post :create, params: { user: { username: nil, password: 'password', password_confirmation: 'password' } }
        end.not_to change(User, :count)
      end

      it 'does not create a new user if the password and password_confirmation do not match' do
        expect do
          post :create, params: { user: { username: 'testusername', password: 'password', password_confirmation: 'randompassword' } }
        end.not_to change(User, :count)
      end

      it 'does not create a new user if the password is empty' do
        expect do
          post :create, params: { user: { username: 'testusername', password: nil, password_confirmation: 'password' } }
        end.not_to change(User, :count)
      end

      it 'does not create a new user if the password_confirmation is empty' do
        expect do
          post :create, params: { user: { username: 'testusername', password: 'password', password_confirmation: nil } }
        end.not_to change(User, :count)
      end

      it 'does not create a new user if the username is an empty string' do
        expect do
          post :create, params: { user: { username: '', password: 'password', password_confirmation: 'password' } }
        end.not_to change(User, :count)
      end

      it 'does not create a new user if the password is an empty string' do
        expect do
          post :create, params: { user: { username: 'testusername', password: '', password_confirmation: 'password' } }
        end.not_to change(User, :count)
      end

      it 'does not create a new user if password confirmation is an empty string' do
        expect do
          post :create, params: { user: { username: 'testusername', password: 'password', password_confirmation: '' } }
        end.not_to change(User, :count)
      end
    end
  end
end
