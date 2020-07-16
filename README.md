# astro_sun_position
Simplified routines for quickly calculating approximate positions of the Sun

These routines were written as excersises for different platforms code for calculating approximate positions of the Sun given a latitude and a day of year. Their main purpose is my own learning and experimentation. The routines are crude and innacurate for most purposes. Their use in production systems is therefore discouraged.


# astro_sun_ephemeris.15c

This is a program designed for the SwissMicros DM15L programmable calculator, a clone of the HP-15C calculator that was popular in the 1980's. It also works on Torsten Manz's HP-15C simulator (http://hp-15c.homepage.t-online.de).

USAGE:

store decimal latitude in register 1:
XX.YYYYY g STO 1
store date in register 2 using format DD.MM:
DD.MM STO 2
store value of altitude below the horizon for which you want to know the hour angle:
D.DDDDD STO 3
store initial date, here taken as the (northern) summer solstice:
20.06 STO 0

run the program:
f E

The program retrieves:
- the minimum altitude of the Sun for the day. This value flashes briefly and is then stored in register 5 (RCL 5)
- the hour angle of the Sun for the desired altitude. This value is shown at the end and stored in register 7 (RCL 7). This value can be converted to approximate setting time by substracting it from 24, or rising by adding it to 0.
- Sun declination for date (RCL 4)
- maximum altitude at midday (RCL 6)

CAVEATS:
The program is barebones and assumes a circular orbit without precession. It does not take into account the equation of time, the refraction of the Sun on Earth's atmosphere, or the minor differences in rising or setting times due to movements of the Earth around its orbit.
