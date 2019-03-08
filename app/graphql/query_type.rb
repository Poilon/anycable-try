QueryType = GraphQL::ObjectType.define do
  name 'Query'

  def query_resources
    Dir.glob("#{File.expand_path('.')}/app/graphql/*/type.rb").map do |dir|
      dir.split('/').last(2).first
    end
  end

  query_resources.each do |resource|
    field resource.singularize do
      description "Return a #{resource.classify}"
      type "#{resource.camelize}::Type".constantize
      argument :id, !types.String
      resolve ApplicationService.call(resource, :show)
    end

    field resource.pluralize do
      description "Return a #{resource.classify}"
      type !types[!"#{resource.camelize}::Type".constantize]
      argument :filter, types.String
      argument :order_by, types.String
      resolve ApplicationService.call(resource, :index)
    end

  end

end
