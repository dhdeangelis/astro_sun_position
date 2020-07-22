#!/usr/local/bin/perl

use warnings;
use strict;

use Math::Trig qw(pi acos);
use Date::Simple qw(date d8 today);

# read site
my $siteLat = shift(@ARGV);
if (!defined $siteLat) { $siteLat = 41.89020 }

# read date
my $epheDate = date(shift(@ARGV));
if (!defined $epheDate) { $epheDate = today() }

# set initial date at solstice
my $epheYear  = $epheDate->year;
my $initDate = date(qq($epheYear-06-21));

# invert signs for southern hemisphere
my $axis_inc = 23.44;
if ($siteLat < 0) { 
	$axis_inc *= -1;
	$siteLat *= -1;
	}

# initial settings
# number ofdays from initial date
my $d = $epheDate - $initDate;

# Sun declination on date
my $sun_decl = $axis_inc * cos($d * (360/365.2442) * (pi/180));
# printf qq(Sun decl: %+5.1f° \n), $sun_decl;

# report
printf qq(\nApproximate Sun positions for latitude %8.5f \t Date: %10s \(%+d days\)\n), $siteLat, $epheDate, $d;

# Sun elevation at astronomical noon
my $sol_elev_max = $sun_decl - $siteLat + 90;
printf qq(Max elev: %+5.2f° \n), $sol_elev_max;

# Sun elevation at astronomical midnight
my $sol_elev_min = $siteLat + $sun_decl - 90;
printf qq(Min elev: %+5.2f° \n), $sol_elev_min;

# hour angles
my @zangles = qw(0 -6 -9 -12 -15 -18);
foreach my $zangle (@zangles) {
	my $h = acos((sin($zangle*pi/180)-(sin($siteLat*pi/180)*sin($sun_decl*pi/180)))/(cos($siteLat*pi/180)*cos($sun_decl*pi/180)))*180/pi;
	printf qq(Time %2d°: %5.2f h - %5.2f h\n), $zangle,  24 - (180-$h)/15, (180-$h)/15;
	}

print qq(\n);
