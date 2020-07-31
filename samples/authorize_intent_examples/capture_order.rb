require_relative "../paypal_client"
include PayPalCheckoutSdk::Payments
module Samples
  module AuthorizeIntentExamples
    class CaptureOrder
      # This function can be used to perform capture on an authorization.
      # An valid authorization id dhould be passed as an argument.
      def capture_order(authorization_id, debug = false)
        request = AuthorizationsCaptureRequest.new(authorization_id)
        request.prefer("return=representation")
        # Below request bodyn can be updated with fields as per business need. Please refer API docs for more info.
        request.request_body({})
        begin
          response = PayPalClient.client.execute(request)
          if debug
            puts "Status Code: #{response.status_code}"
            puts "Status: #{response.result.status}"
            puts "Order ID: #{response.result.id}"
            puts "Intent: #{response.result.intent}"
            puts "Links:"
            response.result.links.each do |link|
              # this could also be called as link.rel or link.href but as method is a reserved keyword for ruby avoid calling link.method
              puts "\t#{link['rel']}: #{link['href']}\tCall Type: #{link['method']}"
            end
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

# This is the driver function which invokes the capture_order function with valid authorization id
# Authorization Id should be replaced with an valid authorization id.
if $PROGRAM_NAME == __FILE__
  Samples::AuthorizeIntentExamples::CaptureOrder.new.capture_order("4KH16819Y83216409", true)
end
