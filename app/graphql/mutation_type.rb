MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  def mutation_resources
    mutations = Dir.glob("#{File.expand_path('.')}/app/graphql/*/mutations/*.rb").reject do |e|
      e.end_with?('type.rb', 'types.rb')
    end
    mutations = mutations.map { |e| e.split('/').last.gsub('.rb', '') }.uniq
    mutations.each_with_object({}) do |meth, h|
      h[meth] = Dir.glob("#{File.expand_path('.')}/app/graphql/*/mutations/#{meth}.rb").map do |dir|
        dir.split('/').last(3).first
      end
    end
  end

  mutation_resources.each do |methd, resources|
    resources.each do |resource|
      field(
        "#{methd}_#{resource.singularize}".to_sym,
        "#{resource.camelize}::Mutations::#{methd.camelize}".constantize
      )
    end
  end

end
