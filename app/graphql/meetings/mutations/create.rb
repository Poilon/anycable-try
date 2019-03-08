Meetings::Mutations::Create = GraphQL::Field.define do
  description 'Creates a Meeting'
  type Meetings::Type

  argument :meeting, !Meetings::Mutations::InputType

  resolve ApplicationService.call(:meeting, :create)
end
