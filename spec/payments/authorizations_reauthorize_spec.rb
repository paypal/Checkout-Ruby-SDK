# frozen_string_literal: true

require_relative '../test_harness'
require_relative '../../lib/paypal_checkout_sdk'
require 'json'

include PayPalCheckoutSdk::Payments

describe AuthorizationsReauthorizeRequest do
  it 'successfully makes a request', skip: 'This test is an example, in production, orders require payer approval' do
    request = AuthorizationsReauthorizeRequest.new('xtIHGdKgdA25uQzr')

    resp = TestHarness.client.execute(request)
    expect(resp.status_code).to eq(201)
    expect(resp.result).not_to be_nil
  end
end
