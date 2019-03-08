require_relative './query_type'
require_relative './mutation_type'

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
