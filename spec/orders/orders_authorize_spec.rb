

require_relative '../test_harness'
require_relative '../../lib/lib'
require 'json'

include PayPalCheckoutSdk::Orders

describe OrdersAuthorizeRequest do

  it 'successfully makes a request', :skip => 'This test is an example, in production, orders require payer approval' do
    request = OrdersAuthorizeRequest.new("ORDER-ID")

    resp = TestHarness::client.execute(request)
    expect(resp.status_code).to eq(201)
    expect(resp.result).not_to be_nil
  end
end
