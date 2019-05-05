require 'test_helper'
require 'timecop'

class ExceptionWrapperTest < ActiveSupport::TestCase
  test 'name returns class name' do
    wrapper = ExceptionNotifier::ExceptionWrapper.new(RuntimeError.new)
    assert_equal "RuntimeError", wrapper.name
  end

  test 'location returns file and line of first line of backtrace' do
    begin
      1/0
    rescue StandardError => e
      exception = e
    end

    wrapper = ExceptionNotifier::ExceptionWrapper.new(exception)
    assert_equal "#{__FILE__}:12", wrapper.location
  end

  test 'location is nil if empty backtrace' do
    wrapper = ExceptionNotifier::ExceptionWrapper.new(RuntimeError.new("Test message"))
    assert_nil wrapper.location
  end

  test 'message returns exception message' do
    wrapper = ExceptionNotifier::ExceptionWrapper.new(RuntimeError.new("Test message"))
    assert_equal 'Test message', wrapper.message
  end
end
