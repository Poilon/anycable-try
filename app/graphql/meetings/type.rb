Meetings::Type = GraphQL::ObjectType.define do
  name 'Meeting'
  field :id, !types.String
  field :created_at, types.String
  field :updated_at, types.String
  field :title, !types.String
  field :starts_at, !types.Int
  field :duration, !types.Int
  field :instructions, !types.String
end
