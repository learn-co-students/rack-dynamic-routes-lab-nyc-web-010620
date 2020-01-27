class Application

    @@items = []

    def call(env)

        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item = req.path.split("/items/").last
            if found_item = @@items.find { |i| i.name == item }
                resp.write "path: #{req.path}"
                resp.write "#{found_item.price}"
                resp.status = 200
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