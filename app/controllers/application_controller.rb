class ApplicationController < ActionController::API
  include ApiCommonResponses
  include ApiTokenAuthenticatable
  wrap_parameters false

  protected

  def serialize_resource(resource, serializer, scope: nil)
    JSON.parse(serializer.new(resource, scope:).to_json)
  end

  def serialize_resource_list(resources, serializer)
    serialized_resource = ActiveModelSerializers::SerializableResource.new(resources, each_serializer: serializer).to_json
    JSON.parse(serialized_resource)
  end

end
