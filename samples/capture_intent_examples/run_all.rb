require_relative '../capture_intent_examples/create_order'
require_relative '../capture_intent_examples/capture_order'
require_relative '../refund_capture'
include PayPalHttp

puts 'Creating Order...'
create_resp = Samples::CaptureIntentExamples::CreateOrder.new.create_order
create_resp.result.links.each do |link|
  # this could also be called as link.rel or link.href but as method is a reserved keyword for ruby avoid calling link.method
  puts "\t#{link['rel']}: #{link['href']}\tCall Type: #{link['method']}"
end
puts "Created Successfully\n"
puts "Copy approve link and paste it in browser. Login with buyer account and follow the instructions.\nOnce approved hit enter..."

# Waiting for user input
gets

puts 'Capturing Order...'
begin
  capture_resp = Samples::CaptureIntentExamples::CaptureOrder.new.capture_order(create_resp.result.id)
  puts "Captured Successfully\n"
  puts "Status Code: #{capture_resp.status_code}"
  puts "Status: #{capture_resp.result.status}"
  puts "Order ID: #{capture_resp.result.id}"
  puts "Intent: #{capture_resp.result.intent}"
  puts 'Links:'
  capture_resp.result.links.each do |link|
    # this could also be called as link.rel or link.href but as method is a reserved keyword for ruby avoid calling link.method
    puts "\t#{link['rel']}: #{link['href']}\tCall Type: #{link['method']}"
  end
rescue StandardError => e
  if e.is_a? HttpError
    puts e.message
    puts e.status_code
    puts e.result
  end
end

puts 'Refunding Capture...'
begin
  refund_response = Samples::RefundCapture.new.refund_capture(capture_resp.result.purchase_units[0].payments.captures[0].id)
  puts "Refunded SuccessFully\n"
  puts "Status Code: #{refund_response.status_code}"
  puts "Status: #{refund_response.result.status}"
  puts "Refund ID: #{refund_response.result.id}"
  puts "Intent: #{refund_response.result.intent}"
  puts 'Links:'
  refund_response.result.links.each do |link|
    # this could also be called as link.rel or link.href but as method is a reserved keyword for ruby avoid calling link.method
    puts "\t#{link['rel']}: #{link['href']}\tCall Type: #{link['method']}"
  end
rescue StandardError => e
  puts e.message
  if e.is_a? HttpError
    puts e.status_code
    puts e.result
  end
end
