This application is in development, what I want to achieve is a simple app that works perfectly in the elementary ecosystem. Basically, this is a project for me to learn programming with Vala.

This aplication uses Fixer.io API to download daily rates of currency exchange for 32 different currencies.

There are many things I want to achieve:

1. I want the app to not need any button for working, giving immediate response to any change in the input, which requires the use of some signals (which I haven't figured out yet).
2. I'd like to be able to select any date to make the convertions (since the api allows to get historical data for any day since 1999).
3. I'd like for the app to update itself in case new currencies get support by Fixer.io.

I know all those things can be done since I have in my mind many ways thought to do them, the main problem right now is that I am still too new with this language.

Everything that I have achieved so far is working, and I believe it looks beautiful, since it is the design I had thought to give it.

This is Open Source, but I plan to monetize this app and every other I make in elementary's appstore, in order of being able to learn more and dedicate more time to programming apps for elementary.

To build you need to run this:
`valac --pkg gtk+-3.0 --pkg libsoup-2.4 --pkg json-glib-1.0 exchange.vala`