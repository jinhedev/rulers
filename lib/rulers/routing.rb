module Rulers
  class Application
    def get_controller_and_action(env)
      _, cont, action, after = env["PATH_INFO"].split('/', 4) # cont == controller
      cont = cont.capitalize # "People"
      cont += "Controller" # PeopleController

      # returns an object of type class and a controller action of type string
      [Object.const_get(cont), action]
    end
  end
end
