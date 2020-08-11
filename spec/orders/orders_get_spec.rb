

require_relative '../test_harness'
require_relative './orders_helper'
require 'json'

include PayPalCheckoutSdk::Orders

describe OrdersGetRequest do

  it 'successfully makes a request' do
    create_resp = OrdersHelper::create_order
    request = OrdersGetRequest.new(create_resp.result.id)
    resp = TestHarness::client.execute(request)
    expect(resp.status_code).to eq(200)
    expect(resp.result).not_to be_nil
    expect(resp.result.intent).to eq('CAPTURE')
    expect(resp.result.purchase_units.count).to eq(1)
    expect(resp.result.purchase_units[0].reference_id).to eq('test_ref_id1')
    expect(resp.result.purchase_units[0].amount.currency_code).to eq('USD')
    expect(resp.result.purchase_units[0].amount.value).to eq('100.00')

    expect(resp.result.create_time).not_to be_nil
    expect(resp.result.links).not_to be_nil
    found_approve = false

    for link in resp.result.links
      if "approve" === link.rel
        expect(link["href"]).not_to be_nil
        expect(link["method"]).to eq("GET")
        found_approve = true
      end
    end
    expect(found_approve).to be_truthy
    expect(resp.result.status).to eq('CREATED')
  end
end
