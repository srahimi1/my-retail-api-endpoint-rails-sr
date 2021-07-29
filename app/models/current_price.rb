class CurrentPrice
	attr_accessor :value, :currency_code

	def initialize(value, currency_code)
		@value = value
		@currency_code = currency_code
	end

	def is_numeric(value)
		sprintf("%.2f",value.to_f) == value
	end
end