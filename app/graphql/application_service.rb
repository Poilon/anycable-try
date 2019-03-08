class ApplicationService

  def initialize(params: {}, object: nil, object_id: nil, user: nil, context: nil)
    @params = params.to_h.symbolize_keys
    @context = context
    @object = object || (object_id && model.visible_for(user: user).find_by(id: object_id))
    @object_id = object_id
    @user = user
  end

  def self.call(resource, meth)
    lambda { |_obj, args, context|
      params = args && args[resource] ? args[resource] : args
      service = "#{resource.to_s.pluralize.camelize.constantize}::Service"
      service = 'ApplicationService' unless defined?(service)
      service.constantize.new(
        params: params, user: context[:current_user],
        object_id: args[:id], context: context
      ).send(meth)
    }
  end

  def index
    puts 'YEAHHHHHHH'
  end

  def create
    puts 'YEAHHHHHHH'
  end

end
