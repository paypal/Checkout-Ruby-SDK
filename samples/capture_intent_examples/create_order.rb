# frozen_string_literal: true

require_relative '../paypal_client'
include PayPalCheckoutSdk::Orders

module Samples
  module CaptureIntentExamples
    class CreateOrder
      # This is the sample function which can be used to create an order. It uses the
      # sample JSON body to create an new Order.
      # The Intent in the request body should be set as "CAPTURE" for capture intent flow.
      def create_order(debug = false)
        body = {
          intent: 'CAPTURE',
          application_context: {
            return_url: 'https://www.example.com',
            cancel_url: 'https://www.example.com',
            brand_name: 'EXAMPLE INC',
            landing_page: 'BILLING',
            shipping_preference: 'SET_PROVIDED_ADDRESS',
            user_action: 'CONTINUE'
          },
          purchase_units: [
            {
              reference_id: 'PUHF',
              description: 'Sporting Goods',

              custom_id: 'CUST-HighFashions',
              soft_descriptor: 'HighFashions',
              amount: {
                currency_code: 'USD',
                value: '220.00',
                breakdown: {
                  item_total: {
                    currency_code: 'USD',
                    value: '180.00'
                  },
                  shipping: {
                    currency_code: 'USD',
                    value: '20.00'
                  },
                  handling: {
                    currency_code: 'USD',
                    value: '10.00'
                  },
                  tax_total: {
                    currency_code: 'USD',
                    value: '20.00'
                  },
                  shipping_discount: {
                    currency_code: 'USD',
                    value: '10'
                  }
                }
              },
              items: [
                {
                  name: 'T-Shirt',
                  description: 'Green XL',
                  sku: 'sku01',
                  unit_amount: {
                    currency_code: 'USD',
                    value: '90.00'
                  },
                  tax: {
                    currency_code: 'USD',
                    value: '10.00'
                  },
                  quantity: '1',
                  category: 'PHYSICAL_GOODS'
                },
                {
                  name: 'Shoes',
                  description: 'Running, Size 10.5',
                  sku: 'sku02',
                  unit_amount: {
                    currency_code: 'USD',
                    value: '45.00'
                  },
                  tax: {
                    currency_code: 'USD',
                    value: '5.00'
                  },
                  quantity: '2',
                  category: 'PHYSICAL_GOODS'
                }
              ],
              shipping: {
                method: 'United States Postal Service',
                name: {
                  full_name: 'John Doe'
                },
                address: {
                  address_line_1: '123 Townsend St',
                  address_line_2: 'Floor 6',
                  admin_area_2: 'San Francisco',
                  admin_area_1: 'CA',
                  postal_code: '94107',
                  country_code: 'US'
                }
              }
            }
          ]
        }

        request = OrdersCreateRequest.new
        request.headers['prefer'] = 'return=representation'
        request.request_body(body)
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
            puts "Gross Amount: #{response.result.purchase_units[0].amount.currency_code} #{response.result.purchase_units[0].amount.value}"
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

# This is the driver function which invokes the createOrder function to create an sample order.
if $PROGRAM_NAME == __FILE__
  Samples::CaptureIntentExamples::CreateOrder.new.create_order(true)
end
