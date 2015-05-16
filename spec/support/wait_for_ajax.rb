module WaitForAjax
  def wait_for_ajax(max_wait_time = 30)
    Timeout.timeout(max_wait_time) { sleep 0.1 while pending_ajax_requests? }
  end

  def pending_ajax_requests?
    page.driver.network_traffic.collect(&:response_parts).any?(&:empty?)
  end
end

RSpec.configure do |config|
  config.include WaitForAjax
end
