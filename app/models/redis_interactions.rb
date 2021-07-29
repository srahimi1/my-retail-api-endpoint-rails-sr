class RedisInteractions

	def set_initial_price(id)
		output = "pass"
		begin
			$redis.setnx("product_#{id}_value", "#{100 + rand(300)}")
        	$redis.setnx("product_#{id}_currency_code", "USD")
		rescue => e
            output = e.message
        end # end begin rescue
		output
	end # end set_initial_price

	def get_price(id)
		output = ""
		begin
			value = $redis.get("product_#{id}_value")
        	cc = $redis.get("product_#{id}_currency_code")
			output = CurrentPrice.new(value,cc)
		rescue => e
            output = e.message
        end # end begin rescue
		output
	end # end get_price

	def set_price(id, value, currency_code)
		output = "pass"
		begin
			$redis.set("product_#{id}_value", value)
	        if currency_code.present?
	            $redis.set("product_#{id}_currency_code", currency_code)
	        end # end if
		rescue => e
            output = e.message
        end # end begin rescue
        output
	end # end set_price

end # end class RedisInteractions