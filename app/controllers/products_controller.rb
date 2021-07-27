class ProductsController < ApplicationController

	def show
        id = params[:id]
        product = Product.retrieve_data(id)
        output = ""
        if product.length == 1
            productHash = {}
            productHash["id"] = id
            productHash["product_name"] = product[0]["product_name"]
            productHash["product_description"] = product[0]["product_description"]
            productHash["product_image_url"] = product[0]["product_image_url"]
            productHash["current_price"] = {value: $redis.get("product_#{id}_value"), currency_code: $redis.get("product_#{id}_currency_code")}
            output = "pass_" + productHash.to_json
        else
            output = "fail_" + product[1]
        end # end if else
        render plain: output
	end # end show

    def edit
        id = params[:id]
        parsed_input = params[:data].present? ? JSON.parse(params[:data]) : ""
        output = "fail"
        if parsed_input.present?
            value = parsed_input["current_price"]["value"].present? ? parsed_input["current_price"]["value"] : nil
            currency_code = parsed_input["current_price"]["currency_code"].present? ? parsed_input["current_price"]["currency_code"] : nil
            if id.present? && value.present? && (sprintf("%.2f",value.to_f) == value)
                output = Product.save_to_nosql(id, value, currency_code)
            elsif (sprintf("%.2f",value.to_f) != value)
                output = "fail"
            end # end if elsif
        else
            output = "empty"
        end # end if else
        render plain: output
    end # end edit
end