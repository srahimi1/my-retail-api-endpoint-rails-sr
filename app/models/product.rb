class Product
	require 'net/http'
	require 'uri'
	attr_accessor :id, :product_name, :product_description, :product_image_url, :errorMsg

	def initialize
		@redis_interactions = RedisInteractions.new
		@current_price = CurrentPrice.new("", "USD")
		product_reset
	end # end initialize

	def product_reset
		@id = "-1";
        @product_name = "";
        @product_description = "";
        @product_image_url = "";
        @errorMsg = "";
        @current_price.value = "";
        @current_price.currency_code = "USD";
	end # end product_reset

	def get_from_api(id)
        puts "in get_from_api in products model top"
        product_reset
		@id = id
		uri = ENV['REMOTE_API_URI_1_1'] + id + ENV['REMOTE_API_URI_1_2']
        begin
        	net_response = Net::HTTP.get(URI.parse(uri)).to_s
        rescue => e
        	@errorMsg = get_error_message(1,e)
        end # end begin rescue
        if net_response.present? && @errorMsg.blank?
        	hashed = JSON.parse(net_response)
        	puts
        	puts "in get_from_api in products model middle, hashed is: #{hashed}"
        	puts
        	puts hashed.inspect
        	puts
        	puts
        	begin
        		@product_name = hashed["product"]["item"]["product_description"]["title"]
        		@product_description = hashed["product"]["item"]["product_description"]["downstream_description"]
        		@product_image_url = hashed["product"]["item"]["enrichment"]["images"][0]["base_url"] + hashed["product"]["item"]["enrichment"]["images"][0]["primary"]
        		# this is only for demonstration purposes to set redis db with test data to retrieve later
        		@redis_interactions.set_intial_price(@id)
        		@current_price = @redis_interactions.get_price(@id)
        		puts "@current_price is #{@current_price} and #{@current_price.inspect}"
        		# end of demonstration code
        	rescue => e
        		@errorMsg = get_error_message(2,e)
       		end # end begin rescue
        end # end if
	end # end get_from_api

	def get_error_message(section, error)
		output = ""
		if section == 2 && error.class.to_s == "NoMethodError"
			output = "Product with id #{@id} cannot be found" 
		else 
			output = error.message
		end # end if else
		return output
	end # end get_error_message

	def set_price(id, value, currency_code)
		output = ""
		begin
            output = @redis_interactions.set_price(id, value, currency_code)
        rescue => e
            output = e.message
        end # end begin rescue
		return output
	end # end set_price
end # end class Product