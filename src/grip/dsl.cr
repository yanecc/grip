# Grip DSL is defined here and it's baked into global scope.
#
# The DSL currently consists of:
#
# - before_all, after_all
# - error
FILTER_METHODS = %w(all)

def error(status_code : Int32, &block : HTTP::Server::Context, Exception -> _)
  Grip.config.add_error_handler status_code, &block
end

# All the helper methods available are:
#  - before_all
#  - after_all
{% for type in ["before", "after"] %}
  {% for method in FILTER_METHODS %}
    def {{type.id}}_{{method.id}}(path : String = "*", &block : HTTP::Server::Context -> _)
     Grip::FilterHandler::INSTANCE.{{type.id}}({{method}}.upcase, path, &block)
    end
  {% end %}
{% end %}
