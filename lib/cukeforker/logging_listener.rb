require "logger"

module CukeForker
  class LoggingListener < AbstractListener
    TIME_FORMAT = "%Y-%m-%d %H:%M:%S"

    def initialize(io = STDOUT)
      @io = io
    end

    def on_run_starting
      log.info "[    run           ] starting"
    end

    def on_worker_starting(worker)
      log.info "[    worker(#{worker.id})     ] starting: #{worker.feature}"
    end

    def on_worker_finished(worker)
      log.info "[    worker(#{worker.id})     ] finished: #{worker.feature}"
    end

    def on_run_finished(failed)
      log.info "[    run           ] finished, #{failed ? 'failed' : 'passed'}"
    end

    def on_run_interrupted
      puts "\n"
      log.info "[    run           ] interrupted"
    end

    def on_display_fetched(server)
      log.info "[    display(#{server.display})   ] fetched"
    end

    def on_display_released(server)
      log.info "[    display(#{server.display})   ] released"
    end

    def on_display_starting(server)
      log.info "[    display(#{server.display})   ] starting"
    end

    def on_display_stopped(server)
      log.info "[    display(#{server.display})   ] stopping"
    end

    private

    def log
      @log ||= (
        log = Logger.new @io
        log.datetime_format = TIME_FORMAT

        log
      )
    end
  end # LoggingListener

end # CukeForker