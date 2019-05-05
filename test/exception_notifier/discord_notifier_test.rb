require 'test_helper'
require 'httparty'

class DiscordNotifierTest < ActiveSupport::TestCase
  URL = 'https://discordapp.com/api/webhooks/xxxx/xxxx'

  test 'asd' do
    begin
      1/0
    rescue StandardError => e
      exception = e
    end



    asd  = notifier.call exception

    assert asd.success?, asd.body
  end

  private

  def notifier
    ExceptionNotifier::DiscordNotifier.new(webhook_url: URL, app_name: 'Website')
  end
end
