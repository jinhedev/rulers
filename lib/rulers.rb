require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"

module Rulers
  class Application
    def call(env)
      # handle edge case call for favicon
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      end

      if env['PATH_INFO'] == '/'
          klass = Object.const_get("HomeController")
          act = "index"
          controller = klass.new(env)
        begin
          text = controller.send(act) # assumes return is of string type
          [200, { "Content-Type" => "text/html" }, [text]]
        rescue
          text = "controller action not found #{act}"
          [404, { "Content-Type" => "text/html" }, [text]]
        end
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act) # return value of controller#act
        [200, { "Content-Type" => "text/html" }, [text]]
      rescue
        text = "controller action not found #{act}"
        [400, { "Content-Type" => "text/html" }, [text]]
      end
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
