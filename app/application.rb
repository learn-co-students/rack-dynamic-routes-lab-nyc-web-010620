require_relative 'item.rb'

class Application

    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name= req.path.split("/items/").last
            if  choice_item = @@items.find {|t| t.name == item_name}
                resp.write choice_item.price
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
end
        