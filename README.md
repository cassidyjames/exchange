This is a simple applet to convert currencies that shares the look and feel of elementary OS.

This aplication uses Fixer.io API to download daily rates of currency exchange for 32 different currencies.

What it can do:

1. Automatically downloads most recent rates of exchange for 32 languages from fixer.io
2. Shows an updated result as soon as you change any input (wether you select any currency or change the ammount to convert).

To do:

1. Being able to select any date and make the convertions with that day's rates.
2. Automatically update the currency options in case any new currency gets support from Fixer.io's API.

You can compile with `valac -X -lm --pkg gtk+-3.0 --pkg libsoup-2.4 --pkg json-glib-1.0 exchange.vala`