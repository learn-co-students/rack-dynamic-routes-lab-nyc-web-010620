# Your application should only accept the /items/<ITEM NAME> route. Everything else should 404
# If a user requests /items/<Item Name> it should return the price of that item
# IF a user requests an item that you don't have, then return a 400 and an error message

class Application
@@items = []

   def call(env)
      resp = Rack::Response.new 
      req = Rack::Request.new(env)

      if req.path.match(/items/)
         requested_item_name = req.path.split("/items/").last
         if @@items.find{|item| item.name == requested_item_name}
         # if the requested item name matches an item with the same name in the @@items array, 
         # set the resulting item from the @@items array (an instance object) equal to the variable "confirmed_item"
         # then go in and get the price of that item 
            confirmed_item = @@items.find{|item| item.name == requested_item_name}
            resp.write confirmed_item.price
         else 
            resp.status = 400
            resp.write "Item not found"
         end 
      else
         resp.status = 404
         resp.write "Route not found"
      end 
      resp.finish
   end 

end 