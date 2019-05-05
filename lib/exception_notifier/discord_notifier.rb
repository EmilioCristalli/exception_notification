require 'httparty'
require 'json'

module ExceptionNotifier
  class DiscordNotifier < BaseNotifier
    def call(exception, options = {})
      @options = base_options.merge(options)

      @wrapper = ExceptionWrapper.new(exception)


      url = @options[:webhook_url]
      body = {
        embeds: [
          {
            title: title,
            description: wrapper.message,
            fields: [
              {
                name: 'Backtrace',
                value: backtrace
              }
            ]
          }
        ]
      }

      require "pry-byebug"; binding.pry; 1

      HTTParty.post(url, body: body.to_json)
    end


    private

    attr_reader :options, :wrapper

    def app_name
      "[#{options[:app_name]}]" if options[:app_name]
    end

    def title
      [
        app_name,
        [
          wrapper.name,
          wrapper.location
        ].compact.join(' in ')
      ].compact.join(' ')
    end

    def backtrace
      wrapper.backtrace.first(3).join("\n") if wrapper.backtrace
    end
  end
end
