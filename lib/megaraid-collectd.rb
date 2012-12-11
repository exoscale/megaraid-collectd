require "megaraid-collectd/version"

module Megaraid
  module Collectd
    DEFAULT_INTERVAL = 900 # poll every 15 minute by default
    DEFAULT_HOSTNAME = `hostname`.chomp
    class Check
      def initialize hostname=nil, interval=nil
        @hostname = hostname || DEFAULT_HOSTNAME
        @interval = interval || DEFAULT_INTERVAL
        @interval = interval.to_i
      end

      def run
        while true
          init_stamp = Time.now.to_i
          if `megaclisas-status --nagios` =~ /^RAID ([a-zA-Z]+) - Arrays: OK:(\d+) Bad:(\d+) - Disks: OK:(\d+) Bad:(\d+)/
            array_ok = $2
            array_bad = $3
            disk_ok = $4
            disk_bad = $5

            puts "PUTVAL \"#{@hostname}/megaraid/gauge-array_ok\" interval=#{interval} N:#{array_ok}"
            puts "PUTVAL \"#{@hostname}/megaraid/gauge-array_bad\" interval=#{interval} N:#{array_bad}"
            puts "PUTVAL \"#{hostname}/megaraid/gauge-disk_ok\" interval=#{interval} N:#{disk_ok}"
            puts "PUTVAL \"#{hostname}/megaraid/gauge-disk_bad\" interval=#{interval} N:#{disk_bad}"
          end
          end_stamp = Time.now.to_i

          waitfor = @interval - (end_stamp - init_stamp)
          sleep waitfor if waitfor > 0
        end
      end
    end
  end
end
