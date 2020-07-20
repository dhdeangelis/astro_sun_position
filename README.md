# astro_sun_position
Simplified routines for quickly calculating approximate positions of the Sun

These routines were written as exercises for different platforms and in different languages for calculating approximate positions of the Sun at a given latitude and a day of year. Their main purpose is my own learning and experimentation. The routines are crude and innacurate for most purposes. Their use in production systems is therefore discouraged.


# astro_sun_ephemeris.15c

This is a program designed for the SwissMicros DM15L programmable calculator, a clone of the HP-15C calculator that was popular in the 1980's. It also works on Torsten Manz's HP-15C simulator (http://hp-15c.homepage.t-online.de).

USAGE:

store decimal latitude in register 1 (positive for northern hemisphere, negative for southern hemisphere):
```
XX.YYYYY g STO 1
```

store date in register 2 using format DD.MM:
```
DD.MM STO 2
```

store value of altitude below the horizon for which you want to know the hour angle (this number must be positive, it is the amount to be added to a zenith angle of 90°):
```
D.DDDDD STO 3
```

store initial date:
```
20.06 STO 0
```
- NOTE: this is here taken as the (northern) summer solstice. To give the date of the equinox as a reference instead (21/3), change also line 24 of the program to the sine (key 23), since it is now a cosine (key 24).

run the program:
```
f E
```
The program retrieves:
- the minimum altitude of the Sun for the day. This value flashes briefly and is then stored in register 5 (RCL 5)
- the hour angle of the Sun for the desired altitude. This value is shown at the end and stored in register 7 (RCL 7). This value can be converted to approximate setting time by subtracting it from 24, or rising by adding it to 0.
- Sun declination for date (RCL 4)
- maximum altitude at midday (RCL 6)

CAVEATS:
The program is bare-bones and assumes a circular orbit without precession. It does not take into account the equation of time, the refraction of the Sun on Earth's atmosphere, or the minor differences in rising or setting times due to movements of the Earth around its orbit. I estimate it should be accurate to within 15 minutes.

NOTES:

The main program runs between lines 001 and 084. Lines 085 - 133 are a subroutine to calculate the number of days between the two given dates. This subroutine is an implementation of the recipe given in page 5 of the book "Practical Astronomy with your calculator" by Peter Duffett-Smith.


# astro_sun_ephemeris_simple.pl

This is a Perl 5 program that calculates maximum and minimum elevations of the Sun, and times for the Sun crossing different altitudes below the horizon that are important for astronomical observations. As above, these results are coarse and approximate. Times are given as if midnight time is 24:00 or 00:00, this means no consideration is given to summer time.

The program needs the modules Math::Trig and Date::Simple.

USAGE:

The program needs a latitude and optionally a date. If no latitude is given it just assumes that of Rome, Italy. Latitudes are positive in the northern hemisphere and negative in the southern hemisphere. Dates are given as ISO-8601 strings.

For example, for running the program for latitude -35 (35S) for 2020-07-16:

```
astro_sun_ephemeris simple.pl -35 2020-07-16
```

gives:

```
Approximate Sun positions for latitude 35.00000 	 Date: 2020-07-16 (+25 days)
Max elev: +33.69° 
Min elev: -76.31° 
Time - 0°: 16.94 h -  7.06 h
Time - 6°: 17.48 h -  6.52 h
Time - 9°: 17.74 h -  6.26 h
Time -12°: 18.00 h -  6.00 h
Time -15°: 18.25 h -  5.75 h
Time -18°: 18.51 h -  5.49 h
```

NOTE: for simplicity, negative latitudes are converted to positive in the program. The results are in any case correct for the given southern latitude.
