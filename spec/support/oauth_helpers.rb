# frozen_string_literal: true

module OAuthHelpers
  def token_request_params
    @user ||= Fabricate(:user)
    @application ||= Fabricate(:application)

    {
      grant_type: 'password',
      client_id: @application.uid,
      client_secret: @application.secret,
      email: @user.email,
      password: @user.password
    }
  end

  def create_user_params
    @user ||= Fabricate(:user)
    @application ||= Fabricate(:application)

    {
      password: @user.password,
      email: @user.email,
      client_id: @application.uid,
      client_secret: @application.secret
    }
  end

  def create_token_header(user = nil)
    user ||= Fabricate(:user)

    application = Fabricate(:application)
    access_token = Fabricate(:access_token, resource_owner_id: user.id, application_id: application.id)

    request.headers['Authorization'] = "Bearer #{access_token.token}"

    user
  end
end
