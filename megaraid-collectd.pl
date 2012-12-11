#!/usr/bin/env perl

use strict;
use warnings;
use Env qw($COLLECTD_HOSTNAME $COLLECTD_INTERVAL);

my $hostname;
my $interval;

if (defined($COLLECTD_HOSTNAME)) {
	printf "yeah!\n";
	$hostname = $COLLECTD_HOSTNAME;
} else {
	chomp($hostname = `hostname`);
}

if (defined($COLLECTD_INTERVAL)) {
	$interval = int($COLLECTD_INTERVAL);
} else {
	$interval = 900;
}

printf "hostname=%s\ninterval=%d\n", $hostname, $interval;

while (1) {
	my $init_stamp = time();
	my $status = `megaclisas-status --nagios`;
	if ($status =~ /^RAID ([a-zA-Z]+) - Arrays: OK:(\d+) Bad:(\d+) - Disks: OK:(\d+) Bad:(\d+)/) {
		printf "PUTVAL \"%s/megaraid/gauge-array_ok\" interval=%d N:%d\n", $hostname, $interval, $2; 
		printf "PUTVAL \"%s/megaraid/gauge-array_bad\" interval=%d N:%d\n", $hostname, $interval, $3;
		printf "PUTVAL \"%s/megaraid/gauge-disk_ok\" interval=%d N:%d\n", $hostname, $interval, $4;
		printf "PUTVAL \"%s/megaraid/gauge-disk_bad\" interval=%d N:%d\n", $hostname, $interval, $5;
	}
	my $end_stamp = time();

	my $waitfor = $interval - ($end_stamp - $init_stamp);
	sleep $waitfor if $waitfor > 0;
}
