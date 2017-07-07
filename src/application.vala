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

public class Exchange : Granite.Application {
    construct {
        
        application_id = "com.github.brandonlujan.exchange";
        flags = ApplicationFlags.FLAGS_NONE;
        
        program_name = "Exchange";
        app_years = "2017";
        
        build_version = "1.0.0";
        app_icon = "com.github.brandonlujan.exchange";
        main_url = "https://github.com/brandonlujan/exchange";
        bug_url = "https://github.com/brandonlujan/exchange/issues";
        
        about_documenters = { null };
        about_artists = {"Brandon Luján <brisluar@gmail.com>"};
        about_authors = {"Brandon Luján <brisluar@gmail.com>"};
        about_comments = _("A currency converter with no hassle");
        about_license_type = Gtk.License.GPL_3_0;
        
    }
    
    public override void activate () {
        
        var window = new Gtk.Window ();
        
        var date_picker = new Granite.Widgets.DatePicker.with_format ("%Y-%m-%d");
        date_picker.tooltip_text = _("Select a date to make the convertion");
        date_picker.margin = 6;
        
        var headerbar = new Gtk.HeaderBar ();
        headerbar.show_close_button = true;
        headerbar.pack_end (date_picker);
       
        var grid = new Gtk.Grid ();
        
        var entry = new Gtk.Entry ();
        entry.margin = 0;
        entry.placeholder_text = "0.00";
        entry.set_alignment(1);
        entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "close-symbolic");
        entry.icon_press.connect ((pos, event) => {
            if (pos == Gtk.EntryIconPosition.SECONDARY) {
                entry.set_text ("");
            }
        });
        
        var cur1_combo = new Gtk.ComboBoxText();
        cur1_combo.margin = 6;
        
        var toggle_button = new Gtk.Button.from_icon_name ("object-flip-horizontal-symbolic");
        toggle_button.margin = 6;
        toggle_button.tooltip_text = _("Toggle currencies");
        
        var cur2_combo = new Gtk.ComboBoxText();
        cur2_combo.margin = 6;
        
        var result_label = new Gtk.Label ("");
        result_label.set_markup ("""<span font="36">0.00</span>""");
        result_label.margin = 12;
        
        grid.attach (entry,0,0,1,1);
        grid.attach (cur1_combo,1,0,1,1);
        grid.attach (toggle_button,2,0,1,1);
        grid.attach (cur2_combo,3,0,1,1);
        grid.attach (result_label,0,1,4,2);
        
        Gtk.Settings.get_default().gtk_application_prefer_dark_theme = true;
        window.set_titlebar (headerbar);
        window.title = "";
        window.window_position = Gtk.WindowPosition.CENTER;
        window.resizable = false;
        window.border_width = 12;
        window.add (grid);
        window.show_all ();
        
        add_window (window);
        
        cur1_combo.append ("EUR", "EUR");
        cur2_combo.append ("EUR", "EUR");
        
        var date_selected = date_picker.get_text ();
        var rates = rates_for (date_selected);
        
        foreach (var currency in rates.get_members ()) {
        
            cur1_combo.append (currency, currency);
            cur2_combo.append (currency, currency);
        
        }
        
        cur1_combo.set_active_id ("EUR");
        cur2_combo.set_active_id ("USD");
        
        var cur1_selected = cur1_combo.get_active_id ();
        var cur2_selected = cur2_combo.get_active_id ();
        
        date_picker.changed.connect (() => {
            
            var cur1_temp = cur1_selected;
            var cur2_temp = cur2_selected;
            
            cur1_combo.remove_all ();
            cur2_combo.remove_all ();
            
            cur1_combo.append ("EUR", "EUR");
            cur2_combo.append ("EUR", "EUR");
            
            date_selected = date_picker.get_text ();
            rates = rates_for (date_selected);
            
            foreach (var currency in rates.get_members ()) {
        
                cur1_combo.append (currency, currency);
                cur2_combo.append (currency, currency);
        
            }
            
            cur1_combo.set_active_id (cur1_temp);
            cur2_combo.set_active_id (cur2_temp);
            
        });
        
        var entry_value = double.parse (entry.get_text ());
        
        double cur1_value, cur2_value;
        
        if (cur1_selected == "EUR") { cur1_value = 1; }
        else { cur1_value = rates.get_double_member (cur1_selected); }
        
        if (cur2_selected == "EUR") { cur2_value = 1; }
        else { cur2_value = rates.get_double_member (cur2_selected); }
        
        entry.changed.connect (() => {
        
            entry_value = double.parse (entry.get_text ());
            
            var result = entry_value / cur1_value * cur2_value;
            
            result_label.set_markup ("""<span font="36">%0.2f</span>""".printf(result));
            
        });
        
        cur1_combo.changed.connect (() => {
            
            cur1_selected = cur1_combo.get_active_id ();
            
            if (cur1_selected == "EUR") { cur1_value = 1; }
            else { cur1_value = rates.get_double_member (cur1_selected); }
            
            var result = entry_value / cur1_value * cur2_value;
            
            result_label.set_markup ("""<span font="36">%0.2f</span>""".printf(result));
            
        });
        
        cur2_combo.changed.connect (() => {
            
            cur2_selected = cur2_combo.get_active_id ();
            
            if (cur2_selected == "EUR") { cur2_value = 1; }
            else { cur2_value = rates.get_double_member (cur2_selected); }
            
            var result = entry_value / cur1_value * cur2_value;
            
            result_label.set_markup ("""<span font="36">%0.2f</span>""".printf(result));
            
        });
        
        toggle_button.clicked.connect (() => {
            
            var cur1_temp = cur1_selected;
            var cur2_temp = cur2_selected;
            
            cur1_combo.set_active_id (cur2_temp);
            cur2_combo.set_active_id (cur1_temp);
            
        });
        
        entry.set_text("1.00");
                
    }
    
    public static Json.Object rates_for (string date) {
        
        var uri = @"https://api.fixer.io/%s".printf (date);
        
		var session = new Soup.Session ();
		
		var message = new Soup.Message ("GET", uri);
		session.send_message (message);
		
		var rates = new Json.Object();
		
		try {
			var parser = new Json.Parser ();
			parser.load_from_data ((string) message.response_body.flatten ().data, -1);
			var root_object = parser.get_root ().get_object();
			rates = root_object.get_object_member ("rates");
		} catch (Error e) {
			warning (e.message);
		}
		
		return rates;
    }
    
    public static int main (string [] args) {
        var application = new Exchange ();
        return application.run (args);
    }
}
