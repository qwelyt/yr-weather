#!/usr/bin/perl
use strict;
use warnings;

use Weather::YR;
use DateTime::TimeZone;

my $yr = Weather::YR->new(
	lat => 59.19,
	lon => 18.4,
	tz => DateTime::TimeZone->new( name => 'Europe/Stockholm' )
);

print("\t\tTemp\tWind\t\tHumidity\tFog\n");
my $now = $yr->location_forecast->now;
my $date = "Current   ";
printData($now, $date);

foreach my $day ( @{$yr->location_forecast->days} ){
	printData($day, getDate($day));
}

sub printData {
	my $day = shift;
	my $date = shift;
	my ($temp, $ws, $wd, $humid, $fog) = exctractData($day);
	print($date);

	print("\t", $temp,"⁰C");

	print("\t", $ws,"m/s");
	print(" ", $wd);

	print("\t", $humid);
	print("\t\t", $fog);

	print("\n");
}

sub getDate {
	my $day = shift;
	my $month = $day->date->month() < 10 ? sprintf '%02s', $day->date->month() : $day->date->month();
	my $month_day = $day->date->day() < 10 ? sprintf '%02s', $day->date->day() : $day->date->day();

	my $date = $day->date->year()."-".$month."-".$month_day;
	return $date;
}

sub exctractData {
	my $day = shift;

	my $temp = $day->temperature->celsius;
	my $wind_speed = $day->wind_speed->mps;
	my $wind_direction = $day->wind_direction->name;
	my $humidity = $day->humidity->percent;
	#my $pressure = $day->pressure->value;
	#my $cloudiness = $day->cloudiness->value;
	my $fog = $day->fog->percent;

	return (
	   	$temp,
	   	$wind_speed, 
		$wind_direction, 
		$humidity, 
		#$pressure, 
		#$cloudiness
		$fog
	);
}
