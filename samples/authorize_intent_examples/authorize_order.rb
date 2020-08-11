# frozen_string_literal: true

require_relative '../paypal_client'
include PayPalCheckoutSdk::Orders
module Samples
  module AuthorizeIntentExamples
    class AuthorizeOrder
      # This function can be used to authorize an approved order.
      def authorize_order(order_id, debug = false)
        request = OrdersAuthorizeRequest.new(order_id)
        request.prefer('return=representation')
        # This request body can be updated with fields as per requirement. Please refer API docs for more info.
        request.request_body({})
        begin
          response = PayPalClient.client.execute(request)
          if debug
            puts "Status Code: #{response.status_code}"
            puts "Status: #{response.result.status}"
            puts "Order ID: #{response.result.id}"
            puts "Authorization ID: #{response.result.purchase_units[0].payments.authorizations[0].id}"
            puts "Intent: #{response.result.intent}"
            puts 'Links:'
            response.result.links.each do |link|
              # this could also be called as link.rel or link.href but as method is a reserved keyword for ruby avoid calling link.method
              puts "\t#{link['rel']}: #{link['href']}\tCall Type: #{link['method']}"
            end
            puts 'Authorization Links:'
            response.result.purchase_units[0].payments.authorizations[0].links.each do |link|
              # this could also be called as link.rel or link.href but as method is a reserved keyword for ruby avoid calling link.method
              puts "\t#{link['rel']}: #{link['href']}\tCall Type: #{link['method']}"
            end
            puts 'Buyer:'
            buyer = response.result.payer
            puts "\tEmail Address: #{buyer.email_address}\n\tName: #{buyer.name.given_name} #{buyer.name.surname}\n\tPhone Number: #{buyer.phone.phone_number.national_number}"
            puts PayPalClient.openstruct_to_hash(response.result).to_json
          end
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
end

# This is the driver function which invokes the authorize_order function with approved order id
# Order Id should be replaced with an valid approved order id.
if $PROGRAM_NAME == __FILE__
  Samples::AuthorizeIntentExamples::AuthorizeOrder.new.authorize_order('0CT41921GV4167455', true)
end
