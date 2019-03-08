require_relative './query_type'
require_relative './mutation_type'
require_relative './meetings/type'
require_relative './meetings/service'
require_relative './meetings/mutations/input_type'
require_relative './meetings/mutations/create'

type_error_logger = Logger.new('./log/graphql_type_errors.log')

# Schema definition
NoMeetingsApiSchema = GraphQL::Schema.define do
  mutation(MutationType)
  query(QueryType)
  type_error lambda { |err, query_ctx|
    type_error_logger.error "#{err} for #{query_ctx.query.query_string} \
    with #{query_ctx.query.provided_variables}"

  }
end
