#!/usr/bin/perl
use strict;
use warnings;

use Weather::YR;
use DateTime::TimeZone;
use Text::Table;

my $yr = Weather::YR->new(
	lat => 59.19,
	lon => 18.4,
	lang => "en",
	tz => DateTime::TimeZone->new( name => 'Europe/Stockholm' )
);

print($yr->location_forecast->url);
print("\n");

my @header = [qw/Day Weather Temp(C) Wind(m\/s) Humidity(%) Pressure(hPa) Fog/];

my $date = "Current";
my $now = $yr->location_forecast->now;
my @currentData = extractData($now);
my @arr = ();
push (@arr, $date);
for my $i (0 ..$#currentData){
	push(@arr, $currentData[$i]);
}

my @rows;
push(@rows, \@arr);

foreach my $day ( @{$yr->location_forecast->days} ){
	#$table->add(getDate($day), extractData($day));
	my $date = getDate($day);
	my @data = extractData($day);

	my @arr = ();
	push (@arr, $date);
	for my $i (0 ..$#data){
		push(@arr, $data[$i]);
	}
	push(@rows, \@arr);
}


print(makeTable(@header, \@rows));


sub getDate {
	my $day = shift;
	my $month = $day->date->month() < 10 ? sprintf '%02s', $day->date->month() : $day->date->month();
	my $month_day = $day->date->day() < 10 ? sprintf '%02s', $day->date->day() : $day->date->day();

	my $date = $day->date->year()."-".$month."-".$month_day;
	return $date;
}

sub extractData {
	my $day = shift;

	my $weather = $day->precipitation->symbol->text;
	my $temp = $day->temperature->celsius;
	my $wind_speed = $day->wind_speed->mps;
	my $wind_direction = $day->wind_direction->name;
	my $wind = $wind_speed . " " . $wind_direction;
	my $humidity = $day->humidity->percent;
	my $pressure = $day->pressure->hPa;
	#my $cloudiness = $day->cloudiness->value;
	my $fog = $day->fog->percent;

	my @array = (
		$weather,
	   	$temp,
	   	$wind,
		$humidity, 
		$pressure, 
		#$cloudiness
		$fog
	);

	return (
		@array
	);
}

sub makeTable {
	my ($headers, $rows ) = @_;

	my @rule = qw(- +);
	my @headers = \'| ';
	push @headers => map { $_ => \' | ' } @$headers;
	pop @headers;
	push @headers => \' |';

	unless ('ARRAY' eq ref $rows
		&& 'ARRAY' eq ref $rows->[0]
		&& @$headers == @{ $rows->[0] }) {
		print(
			"makeTable() rows must be an AoA with rows being same size as headers"
		);
	}

	my $table = Text::Table->new(@headers);
	$table->rule(@rule);
	$table->body_rule(@rule);
	$table->load(@$rows);

	return (
		$table->rule(@rule),
		$table->title,
		$table->rule(@rule),
		map({ $table->body($_) } 0 .. @$rows),
		$table->rule(@rule)
	);
}
