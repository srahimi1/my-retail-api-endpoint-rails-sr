class ProductsController < ApplicationController

    def initialize
        @product = Product.new
        @current_price = CurrentPrice.new("","")
    end # end initialize

	def show
        id = params[:id]
        @product.get_from_api(id)
        render json: @product
	end # end show

    def edit
        id = params[:id]
        parsed_input = params[:data].present? ? JSON.parse(params[:data]) : ""
        output = "fail"
        if parsed_input.present?
            value = parsed_input["current_price"]["value"].present? ? parsed_input["current_price"]["value"] : nil
            currency_code = parsed_input["current_price"]["currency_code"].present? ? parsed_input["current_price"]["currency_code"] : nil
            if id.present? && value.present? && @current_price.is_numeric(value)
                output = @product.set_price(id, value, currency_code)
            elsif !@current_price.is_numeric(value)
                output = "fail"
            end # end if elsif
        else
            output = "empty"
        end # end if else
        render plain: output
    end # end edit
end # end class ProductsController