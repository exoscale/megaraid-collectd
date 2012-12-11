#!/usr/bin/env perl

use strict;
use warnings;

my $hostname = $ENV{'COLLECTD_HOSTNAME'} || `hostname`;
my $interval = $ENV{'COLLECTD_INTERVAL'} || 900;

$interval = int($interval);
$hostname = chomp($hostname);

while (1) {
	my $init_stamp = time();
	my $status = `megaclisas-status --nagios`;
	if ($status =~ /^RAID ([a-zA-Z]+) - Arrays: OK:(\d+) Bad:(\d+) - Disks: OK:(\d+) Bad:(\d+)/) {
		printf "PUTVAL \"%s/megaraid/gauge-array_ok\" interval=%d N:%d\n", $hostname, $2, $interval;
		printf "PUTVAL \"%s/megaraid/gauge-array_bad\" interval=%d N:%d\n", $hostname, $3, $interval;
		printf "PUTVAL \"%s/megaraid/gauge-disk_ok\" interval=%d N:%d\n", $hostname, $4, $interval;
		printf "PUTVAL \"%s/megaraid/gauge-disk_bad\" interval=%d N:%d\n", $hostname, $5, $interval;
	}
	my $end_stamp = time();

	my $waitfor = $interval - ($end_stamp - $init_stamp);
	sleep $waitfor if $waitfor > 0;
}
