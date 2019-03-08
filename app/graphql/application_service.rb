class ApplicationService

  def initialize(params: {}, object: nil, object_id: nil, user: nil, context: nil)
    @params = symbolize_keys(params.to_h)
    @context = context
    @object = object || (object_id && model.visible_for(user: user).find_by(id: object_id))
    @object_id = object_id
    @user = user
  end

  def self.call(resource, meth)
    lambda { |_obj, args, context|
      params = args && args[resource] ? args[resource] : args
      "#{resource.to_s.pluralize.camelize.constantize}::Service".constantize.new(
        params: params, user: context[:current_user],
        object_id: args[:id], context: context
      ).send(meth)
    }
  end

  def index
    Meetings::Model.all.to_a
  end

  def create
    Meetings::Model.create(params)
  end

  private

  def symbolize_keys(obj)
    obj.each_with_object({}) do |(key, _), res|
      nkey = case key
             when String
               key.to_sym
             else
               key
             end
      res[nkey] = nval
      res
    end
  end

end
