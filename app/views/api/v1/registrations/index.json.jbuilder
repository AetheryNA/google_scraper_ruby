# frozen_string_literal: true

json.user do
  json.id user.id
  json.email user.email
  json.access_token access_token.token
  json.token_type 'bearer'
  json.expires_in access_token.expires_in
  json.refresh_token access_token.refresh_token
  json.created_at access_token.created_at.to_time.to_i
end
