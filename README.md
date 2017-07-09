# Exchange
## Convert currencies with no hassle

![Screenshot](Screenshot.png)

* Uses [fixer.io](https://www.fixer.io)'s API to convert currencies
* You can go back in time with a date selector to make currencies in their old rates
* It autosaves your last used currencies so you don't have to select them again when relaunching
* Beautiful, with a feel and look of elementary OS

## Install it from elementary's appcenter
[![Get it on AppCenter](http://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.brandonlujan.exchange.desktop)

## Consider donating me to keep on making good content for elementary OS

### Via Bitcoin:
![Bitcoin address](http://i.imgur.com/2tFBXZ2.png)

Bitcoin Address: 1H4vEtWSpsW52vxijK6EqDrfq4Lo1wQ7hE

### Via PayPal
[![Donate me on paypal](http://icons.iconarchive.com/icons/designbolts/credit-card-payment/256/Paypal-icon.png)](https://www.paypal.me/brandonluar)

## To build:

Clone this repo, then:

```
$ meson build && cd build
$ mesonconf -Dprefix=/usr
$ sudo ninja install
```