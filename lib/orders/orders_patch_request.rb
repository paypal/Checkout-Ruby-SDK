# This class was generated on Mon, 27 Aug 2018 13:51:59 PDT by version 0.1.0-dev+904328-dirty of Braintree SDK Generator
# orders_patch_request.rb
# @version 0.1.0-dev+904328-dirty
# @type request
# @data H4sIAAAAAAAC/9RX308jNxB+719h+XmVpbTqQ6Q+REBFf9wlhfSkCqJksCfYx67t2uNcU8T/XtneAJukd0cL6vG2Ox7b37fzefbzLX8LLfIht16iDwMHJBSv+DEG4bUjbQ0f8t+cBMLAwLCcx0gBMQWBkUK2ODo7GU1PjhfMerYYTSZn43fpLRBQDAP2u41MgDGWWMwLPazzQZNii6Pxm8kvJ9M9c1jGk3YJyIDI66tYgEhmr96joDC8jAcH3wiCqwbzI3YBhSB7Ad8fZtDoa/P9JW9wSZe8DI42eyQuZYeSX5P6jOljhx7SRwt7Z9V9DPUuxisr1x8B3UsWVnaMtSE0G6AP4c0u/S3kXuRn6BoQ+6dswf48TC56oSDgPBpN4TmwVQykfCmAF7OBiIFsO9fy2cBWzGNrV/iCoOXDQX1NsB2sEQfYgm5egzSC0s5pc/2aPnGwS5pv5GH9a4IOrY1fdj+7mA20WVkt8P/qF/XOv6J+9A/kFf81ol9PwEOLhD7w4cWs4qcIEn0vesuna5csQCCvzTWv+DvwOi3VWYNRJGW9/iv/2HjFf8b1P4z0XcNICAyBkb1Bw5bett0jGumsNsTq1de1hUjqsM4jA17xkfewLoAOKn6GIMemWfPhEpqAKfBH1B4lH5KPWPGJtw49aQx8aGLT3M0q/oP17TbvCZB6GutsUOZa9gjvcJwqZD8eM7vMTqgzR7bzOc/EJ+VgoLLIPe5J59S2YGfDNPdlSg/79shWsQyDBDVR+el8/LZzXp3JSpzAuWbNHHjS0HQM84DHYKMXGLb4fvdRvl3gMeFPFyWpqEeqC+wWpXBIMisVSeUh8NdITFoRWzTEGiuycos4PyidrKZl6QTm/BU0EQdsg5ktrS+GN2UsmN2YvSfVeQ/vXOjq04p0Per5dZf4PapERdjWNfhEJf57hA5IbWtO/ffyAD0UZ8OonLcXqkBR/S6/LIgewU1kl2EeuT83A5Zii9LeH0mHSYuBpauRL/gYdLJ7Dkazu5QVnDUByzopXPEjmy8MHdsEUJdPXb8PuZGfErk3SMrK1GlG06NTXnooH/J6dVgLheLGRqrLtbG+3XTLO17x8xvt7jGd/OlQEMrzfLE7shL58PDg27uv/gYAAP//
# DO NOT EDIT
require 'cgi'

module PayPalCheckoutSdk
    module Orders

      #
      # Updates an order that has the `CREATED` or `APPROVED` status. You cannot update an order with `COMPLETED` status. You can patch these attributes and objects:<table><thead><tr><th align="left">Attribute or object</th><th align="left">Operations</th></tr></thead><tbody><tr><td><code>intent</code></td><td align="left">Replace</td></tr><tr><td><code>purchase_units</code></td><td align="left">Replace, add</td></tr><tr><td><code>purchase_units[].custom_id</code></td><td align="left">Replace, add, remove</td></tr><tr><td><code>purchase_units[].description</code></td><td align="left">Replace, add, remove</td></tr><tr><td><code>purchase_units[].payee.email</code></td><td align="left">Replace, add</td></tr><tr><td><code>purchase_units[].shipping</code></td><td align="left">Replace, add, remove</td></tr><tr><td><code>purchase_units[].soft_descriptor</code></td><td align="left">Replace, add, remove</td></tr><tr><td><code>purchase_units[].amount</code></td><td align="left">Replace</td></tr><tr><td><code>purchase_units[].invoice_id</code></td><td align="left">Replace, add, remove</td></tr></tbody></table>
      #
      class OrdersPatchRequest
        attr_accessor :path, :body, :headers, :verb

        def initialize(order_id)
          @headers = {}
          @body = nil
          @verb = "PATCH"
          @path = "/v2/checkout/orders/{order_id}?"

          @path = @path.gsub("{order_id}", CGI::escape(order_id.to_s))
          @headers["Content-Type"] = "application/json"
        end

        def request_body(patchRequest)
          @body = patchRequest
        end
      end
    end
end
