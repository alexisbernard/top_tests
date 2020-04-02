module Minitest
  def self.plugin_top_tests_init(options)
    self.reporter << TopTestReporter.new(options)
  end

  def self.plugin_top_tests_options(opts, options)
    opts.on "--max-time=ms", "Test fails if it exceeds specified time in seconds" do |max_time|
      options[:max_time] = max_time.to_f
    end
  end

  class TopTestReporter < AbstractReporter
    attr_reader :results, :max_time

    def initialize(options)
      @results = []
      @max_time = options[:max_time]
    end

    def record(result)
      results << result
      #result.refute(true, "Too long") if max_time && result.time > max_time
    end

    def passed?
      slow_tests.empty?
    end

    def report
      if slow_tests.empty?
        puts "\nTop 10 slowest tests:\n#{format_tests(slowest_results[0,10])}"
      else
        print_slow_tests
      end
    end

    def slowest_results
      results.sort { |a, b| b.time <=> a.time }
    end

    def slow_tests
      max_time ? results.find_all { |r| r.time > max_time } : []
    end

    def print_slow_tests
      if !slow_tests.empty?
        if slow_tests.size == 1
          puts "\n1 test is taking longer than #{max_time} seconds:"
        else
          puts "\n3 tests are taking longer than #{max_time} seconds:"
        end
        puts format_tests(slow_tests)
      end
    end

    def format_tests(tests)
      tests.map { |t| "  #{format("%7.3f", t.time)} #{t.klass}##{t.name}" }.join("\n")
    end
  end
end
