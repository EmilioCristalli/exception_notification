module ExceptionNotifier
  class ExceptionWrapper
    BACKTRACE_LINE_REGEX = /^((?:[a-zA-Z]:)?[^:]+):(\d+)(?::in `([^']+)')?$/

    def initialize(exception)
      @exception = exception
    end

    def name
      exception.class.to_s
    end

    def location
      return nil if !backtrace || backtrace.empty?

      backtrace.first.match(BACKTRACE_LINE_REGEX)

      file, line_str, method = [$1, $2, $3]

      "#{file}:#{line_str}"
    end

    def message
      exception.message
    end

    def backtrace
      @backtrace ||= exception.backtrace
    end

    private

    attr_reader :exception
  end
end
