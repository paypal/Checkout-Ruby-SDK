# frozen_string_literal: true

require_relative './paypal_client'
require_relative './authorize_intent_examples/create_order'
require 'json'
require 'ostruct'

include PayPalCheckoutSdk::Orders
module Samples
  class GetOrder
    # This function can be used to retrieve an order by passing order id as argument
    def get_order(order_id)
      request = OrdersGetRequest.new(order_id)
      begin
        response = PayPalClient.client.execute(request)
        puts "Status Code: #{response.status_code}"
        puts "Status: #{response.result.status}"
        puts "Order ID: #{response.result.id}"
        puts "Intent: #{response.result.intent}"
        puts 'Links:'
        response.result.links.each do |link|
          # this could also be called as link.rel or link.href but as method is a reserved keyword for ruby avoid calling link.method
          puts "\t#{link['rel']}: #{link['href']}\tCall Type: #{link['method']}"
        end
        puts "Gross Amount: #{response.result.purchase_units[0].amount.currency_code} #{response.result.purchase_units[0].amount.value}"
        puts PayPalClient.openstruct_to_hash(response.result).to_json
        response
      rescue PayPalHttp::HttpError => e
        # Exception occured while processing the refund.
        puts " Status Code: #{e.status_code}"
        puts " Debug Id: #{e.result.debug_id}"
        puts " Response: #{e.result}"
      end
    end
  end
end

# This is the driver function which invokes the get_order function with order id to retrieve
# an sample order. For the order id, we invoke the create order to create an new order and then we are using
# the newly created order id for retrieving the order
if $PROGRAM_NAME == __FILE__
  id = Samples::AuthorizeIntentExamples::CreateOrder.new.create_order.result.id
  Samples::GetOrder.new.get_order(id)
end
