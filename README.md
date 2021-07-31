# my-retail-api-endpoint-rails-sr

This server-side code is a back-end api service written in Ruby and using the Rails framework. It serves to respond to api requests to retrieve data or update data for products in myRetail's products collection. 

Details of the code include:

* A 'router' file, 'routes.rb', located in the 'config' directory under root, which receives incoming https 'GET' and 'PUT' requests and calls the indicated methods in a 'controller' file.  

* A 'controller' file, 'products_controller.rb', located in the '/app/controllers' directory, that contains the methods that handle the https requests. 'GET' requests from the front-end are handled by this controller's 'show' method. This method retrieves data from another api source, via a 'GET' request, and pricing data from a remote Redis in-memory NoSQL source, and assigns it to the corresponding fields of an instance of the Product class/model. The JSON string response is rendered using Rails' 'render json' method on that Product instance.

* 'PUT' requests from the front-end are handled by the 'products' controller's 'edit' method. This method parses the string in the 'data' url parameter and produces a JSON object via methods from the 'JSON' JSON processing library. The JSON data is then used to update pricing data in the remote Redis NoSQL source.

* CORS restrictions are accounted for by use of the gem 'rack-cors' which acts as middle-ware, intercepting and processing requests before they are sent to the router.
