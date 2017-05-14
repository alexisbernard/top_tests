module Minitest
  def self.plugin_top_tests_init(options)
    self.reporter << TopTestReporter.new
  end

  class TopTestReporter < AbstractReporter
    attr_reader :results

    def initialize
      @results = []
    end

    def record(result)
      results << result
    end

    def report
      puts "\nTop 10 slowest tests:"
      puts slowest_results[0,10].map { |r| "  #{format("%7.3f", r.time)} #{r.class}##{r.name}" }.join("\n")
    end

    def slowest_results
      results.sort { |a, b| b.time <=> a.time }
    end
  end
end
