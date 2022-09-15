# frozen_string_literal: true

require 'rails_helper'
require 'ffaker'

RSpec.describe User, type: :model do
  describe 'user model' do
    context 'when validation is run' do
      it { is_expected.to validate_presence_of(:username) }
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_presence_of(:password_confirmation) }
    end

    context 'given a minimum length set' do
      it { is_expected.to validate_length_of(:username) }
      it { is_expected.to validate_length_of(:password) }
    end

    context 'given uniqueness set' do
      subject { Fabricate(:user, username: 'testusername', password: 'password', password_confirmation: 'password') }

      it { is_expected.to validate_uniqueness_of(:username) }
    end

    context 'given secure password' do
      it { is_expected.to have_secure_password }
    end
  end
end
