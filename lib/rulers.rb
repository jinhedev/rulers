require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"

require "rulers/file_model"

module Rulers
  class Application
    def call(env)
      # handle edge case call for favicon
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      end

      # if env['PATH_INFO'] == '/'
      #   byebug
      #   klass = Object.const_get("HomeController")
      #   act = "index"
      #   controller = klass.new(env)
      #   begin
      #     text = controller.send(act) # assumes return is of string type
      #     return [200, { "Content-Type" => "text/html" }, [text]]
      #   rescue
      #     text = "controller action not found #{act}"
      #     return [404, { "Content-Type" => "text/html" }, [text]]
      #   end
      # end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act) # return value of controller#act
        return [200, { "Content-Type" => "text/html" }, [text]]
      rescue
        text = "controller action not found #{act}"
        return [400, { "Content-Type" => "text/html" }, [text]]
      end
    end
  end
end
