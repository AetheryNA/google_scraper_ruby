class UserSerializer
  include JSONAPI::Serializer

  attributes :email

  has_many :keywords
end
