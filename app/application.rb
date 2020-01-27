require_relative '../config/environment.rb'

class Application
    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        
        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            
            if self.exists?(item_name)
                item = @@items.find { |item| item.name == item_name }
                resp.status = 200
                resp.write(item.price.to_s)
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end

    def exists?(item_name)
        return true if @@items.find { |item| item.name == item_name }

        false
    end
end