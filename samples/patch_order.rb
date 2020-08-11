# frozen_string_literal: true

require_relative './paypal_client'
require_relative './capture_intent_examples/create_order'
require_relative './get_order'

include PayPalCheckoutSdk::Orders

module Samples
  class PatchOrder
    # Below function can be used to patch and order.
    # Patch is supported on only specific set of fields.
    # Please refer API docs for more info.
    def patch_order(order_id)
      body = [{
        op: 'replace',
        path: "/purchase_units/@reference_id=='PUHF'/description",
        value: 'Sporting goods description'
      },
              {
                op: 'replace',
                path: "/purchase_units/@reference_id=='PUHF'/custom_id",
                value: 'CUST-ID-HighFashions'
              }]
      request = OrdersPatchRequest.new(order_id)
      request.request_body(body)
      response = PayPalClient.client.execute(request)
      response
    end
  end
end

# Driver function which does below steps.
# 1. Create an Order
# 2. Patch fields in the newly created order.
# 3. Print the updated fields by calling the get order.
if $PROGRAM_NAME == __FILE__
  begin
    order = Samples::CaptureIntentExamples::CreateOrder.new.create_order.result
    patch_response = Samples::PatchOrder.new.patch_order(order.id)
    puts "patch_response status code ::: #{patch_response.status_code}"
    if patch_response.status_code == 204
      order = Samples::GetOrder.new.get_order(order.id)
      puts "Updated Description: #{order.result.purchase_units[0].description}"
      puts "Updated Custom Id: #{order.result.purchase_units[0].custom_id}"
      puts PayPalClient.openstruct_to_hash(order.result).to_json
    end
  rescue PayPalHttp::HttpError => e
    # Exception occured while processing the refund.
    puts " Status Code: #{e.status_code}"
    puts " Debug Id: #{e.result.debug_id}"
    puts " Response: #{e.result}"
  end
end
