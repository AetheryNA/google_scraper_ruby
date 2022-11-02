class LinkSerializer
  include JSONAPI::Serializer

  attributes :url, :link_type, :created_at
end
