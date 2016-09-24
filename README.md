TennisKata
==========

Evaluation
----------

I may want to add the Serial instance for enum/bounded to the default
test file.  It is very generically useful.

I think I got all the rules (plus Game stays Game) within the 25
minutes this time.  It's good to follow the description on
http://www.codingdojo.org/cgi-bin/index.pl?KataTennis by step by
step.  These steps do not (yet?) resonate with my intuition of
describing a domain, though; the order in which I added the tests
feels a bit random.

I do not really like the end result.  The `score` function looks a bit
off.  I *do* like that there is no longer a "catch all" default
situation (as opposed to yesterday's result).

I now see a failing test that I haven't written yet, having to do with
the "illegal" state `Points Forty Forty`.  The second property test
succeeds on that state, and it should not be there.

Finally, I would still like to write a more generic property test,
iterating over a list of balls.  The properties I declared here, feel
more like "unit tests with a bit of random" then real properties,
because of the way the input is set up specifically, instead of
generalizing properties of the `score` function.
