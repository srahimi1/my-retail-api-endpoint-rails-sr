class Product < ApplicationRecord
	require 'net/http'
	require 'uri'

	def self.retrieve_data(id)
		@id = id
		output = [""]
		uri = ENV['REMOTE_API_URI_1_1'] + id + ENV['REMOTE_API_URI_1_2']
        begin
        	net_response = Net::HTTP.get(URI.parse(uri)).to_s
        rescue => e
        	output[1] = get_error_message(1,e)
        end # end begin rescue
        product_name = ""
        if net_response.present? && output.length == 1
        	hashed = JSON.parse(net_response)
        	begin
        		product_name = hashed["product"]["item"]["product_description"]["title"]
        		product_description = hashed["product"]["item"]["product_description"]["downstream_description"]
        		product_image_url = hashed["product"]["item"]["enrichment"]["images"][0]["base_url"] + hashed["product"]["item"]["enrichment"]["images"][0]["primary"]
        		output[0] = {"product_name" => product_name, "product_description" => product_description, "product_image_url" => product_image_url}
        		# this is only for demonstration purposes to set redis db with test data to retrieve later
        		$redis.setnx("product_#{@id}_value", "#{100 + rand(300)}")
        		$redis.setnx("product_#{@id}_currency_code", "USD")
        		# end of demonstration code
        	rescue => e
        		output[1] = get_error_message(2,e)
       		end # end begin rescue
        end # end if
        return output
	end # end retrieve_data

	def self.get_error_message(section, error)
		output = ""
		if section == 2 && error.class.to_s == "NoMethodError"
			output = "record of product with id #{@id} cannot be found" 
		else 
			output = error.message
		end # end if else
		return output
	end # end get_error_message

	def self.save_to_nosql(id, value, currency_code)
		output = ""
		begin
            $redis.set("product_#{id}_value", value)
            if currency_code.present?
                $redis.set("product_#{id}_currency_code", currency_code)
            end # end if
            output = "pass"
        rescue => e
            output = e.message
        end # end begin rescue
		return output
	end
end