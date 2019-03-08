Meetings::Mutations::InputType = GraphQL::InputObjectType.define do
  name 'MeetingInputType'
  description 'Properties for updating a Meeting'

  argument :starts_at, !types.Int
  argument :instructions, !types.String
  argument :title, !types.String

end
