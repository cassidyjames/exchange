/*
* Copyright (c) 2017 Brandon Luján
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*/

using Soup;
using Json;
using Gtk;

public class mainwindow : Gtk.Dialog {
	public mainwindow () {
		Gtk.Settings.get_default().gtk_application_prefer_dark_theme = true;
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.border_width = 12;
		this.title = _("Exchange");
		this.resizable = false;
		var grid = new Gtk.Grid ();
		var entry = new Gtk.Entry ();
		grid.attach (entry,0,0,1,1);
		entry.margin = 6;
		entry.placeholder_text = "0.00";
		entry.set_alignment(1);
		entry.set_text("1.00");
		entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "close-symbolic");
    entry.icon_press.connect ((pos, event) => {
      if (pos == Gtk.EntryIconPosition.SECONDARY) {
        entry.set_text ("");
      }
    });
		var base_currency = new Gtk.ComboBoxText();
		base_currency.append_text("AUD");
		base_currency.append_text("BGN");
		base_currency.append_text("BRL");
		base_currency.append_text("CAD");
		base_currency.append_text("CHF");
		base_currency.append_text("CNY");
		base_currency.append_text("CZK");
		base_currency.append_text("DKK");
		base_currency.append_text("EUR");
		base_currency.append_text("GBP");
		base_currency.append_text("HKD");
		base_currency.append_text("HRK");
		base_currency.append_text("HUF");
		base_currency.append_text("IDR");
		base_currency.append_text("ILS");
		base_currency.append_text("INR");
		base_currency.append_text("JPY");
		base_currency.append_text("KRW");
		base_currency.append_text("MXN");
		base_currency.append_text("MYR");
		base_currency.append_text("NOK");
		base_currency.append_text("NZD");
		base_currency.append_text("PHP");
		base_currency.append_text("PLN");
		base_currency.append_text("RON");
		base_currency.append_text("RUB");
		base_currency.append_text("SEK");
		base_currency.append_text("SGD");
		base_currency.append_text("THB");
		base_currency.append_text("TRY");
		base_currency.append_text("USD");
		base_currency.append_text("ZAR");
		base_currency.set_active(8);
		grid.attach (base_currency,1,0,1,1);
		base_currency.margin = 6;
		var to = new Gtk.Button.from_icon_name ("object-flip-horizontal-symbolic");
		grid.attach (to,2,0,1,1);
		to.margin = 6;
		var result_currency = new Gtk.ComboBoxText();
		result_currency.append_text("AUD");
		result_currency.append_text("BGN");
		result_currency.append_text("BRL");
		result_currency.append_text("CAD");
		result_currency.append_text("CHF");
		result_currency.append_text("CNY");
		result_currency.append_text("CZK");
		result_currency.append_text("DKK");
		result_currency.append_text("EUR");
		result_currency.append_text("GBP");
		result_currency.append_text("HKD");
		result_currency.append_text("HRK");
		result_currency.append_text("HUF");
		result_currency.append_text("IDR");
		result_currency.append_text("ILS");
		result_currency.append_text("INR");
		result_currency.append_text("JPY");
		result_currency.append_text("KRW");
		result_currency.append_text("MXN");
		result_currency.append_text("MYR");
		result_currency.append_text("NOK");
		result_currency.append_text("NZD");
		result_currency.append_text("PHP");
		result_currency.append_text("PLN");
		result_currency.append_text("RON");
		result_currency.append_text("RUB");
		result_currency.append_text("SEK");
		result_currency.append_text("SGD");
		result_currency.append_text("THB");
		result_currency.append_text("TRY");
		result_currency.append_text("USD");
		result_currency.append_text("ZAR");
		result_currency.set_active(30);
		grid.attach (result_currency,3,0,1,1);
		result_currency.margin = 6;
		var label_result = new Gtk.Label ("0.00");			
		grid.attach (label_result,0,1,4,2);
		label_result.margin = 12;
		var content_box = get_content_area () as Gtk.Box;
		content_box.border_width = 0;
		content_box.add (grid);
		content_box.show_all ();
		var uri = "http://api.fixer.io/latest";
		var session = new Soup.Session ();
		var message = new Soup.Message ("GET", uri);
		session.send_message (message);
		try {
			var parser = new Json.Parser ();
			parser.load_from_data ((string) message.response_body.flatten ().data, -1);
			var root_object = parser.get_root ().get_object();
			var rates = root_object.get_object_member ("rates");
			var curname1 = base_currency.get_active_text();
			var curname2 = result_currency.get_active_text();
			double currency1;
			double currency2;
			if (curname1 == "EUR") {currency1 = 1.0000;}
			else {currency1 = rates.get_double_member (base_currency.get_active_text());}
			if (curname2 == "EUR") {currency2 = 1.0000;}
			else {currency2 = rates.get_double_member (result_currency.get_active_text());}
			var conv_result = double.parse(entry.get_text ()) * currency2 / currency1;
			label_result.set_markup ("""<span font="36">%0.2f</span>""".printf(conv_result));
			entry.changed.connect (() => {
				conv_result = double.parse(entry.get_text ()) * currency2 / currency1;
				label_result.set_markup ("""<span font="36">%0.2f</span>""".printf(conv_result));
			});
			base_currency.changed.connect (() => {
				curname1 = base_currency.get_active_text();
				if (curname1 == "EUR") {currency1 = 1.0000;}
				else {currency1 = rates.get_double_member (base_currency.get_active_text());}
				conv_result = double.parse(entry.get_text ()) * currency2 / currency1;
				label_result.set_markup ("""<span font="36">%0.2f</span>""".printf(conv_result));
			});
			result_currency.changed.connect (() => {
				curname2 = result_currency.get_active_text();
				if (curname2 == "EUR") {currency2 = 1.0000;}
				else {currency2 = rates.get_double_member (result_currency.get_active_text());}
				conv_result = double.parse(entry.get_text ()) * currency2 / currency1;
				label_result.set_markup ("""<span font="36">%0.2f</span>""".printf(conv_result));
			});
			to.clicked.connect (() => {
				var change1 = base_currency.get_active ();
				var change2 = result_currency.get_active ();
				base_currency.set_active (change2);
				result_currency.set_active (change1);
			});
		}
		catch (Error e) {
			warning (e.message);
		}
	}
	public static int main (string[] args) {
		Gtk.init (ref args);
		var exchange = new mainwindow ();
		exchange.show_all ();
		Gtk.main ();
		return 0;
	}
}
