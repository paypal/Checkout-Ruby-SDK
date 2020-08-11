# frozen_string_literal: true

require_relative '../paypal_client' # PayPal SDK dependency
include PayPalCheckoutSdk::Orders
module Samples
  module CaptureIntentExamples
    class CaptureOrder
      # This is the sample function performing payment capture on the order.
      # Approved Order id should be passed as an argument to this function
      def capture_order(order_id, debug = false)
        request = OrdersCaptureRequest.new(order_id)
        request.prefer('return=representation')
        begin
          response = PayPalClient.client.execute(request)
          if debug
            puts "Status Code: #{response.status_code}"
            puts "Status: #{response.result.status}"
            puts "Order ID: #{response.result.id}"
            puts "Intent: #{response.result.intent}"
            puts 'Links:'
            response.result.links.each do |link|
              # this could also be called as link.rel or link.href but as method is a reserved keyword for ruby avoid calling link.method
              puts "\t#{link['rel']}: #{link['href']}\tCall Type: #{link['method']}"
            end
            puts 'Capture Ids: '
            response.result.purchase_units.each do |purchase_unit|
              purchase_unit.payments.captures.each do |capture|
                puts "\t #{capture.id}"
              end
            end
            puts 'Buyer:'
            buyer = response.result.payer
            puts "\tEmail Address: #{buyer.email_address}\n\tName: #{buyer.name.full_name}\n\tPhone Number: #{buyer.phone.phone_number.national_number}"
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
# This is the driver function which invokes the capture order function.
# Order Id value should be replaced with the approved order id.
if $PROGRAM_NAME == __FILE__
  Samples::CaptureIntentExamples::CaptureOrder.new.capture_order('4BH32103UX0864942', true)
end
