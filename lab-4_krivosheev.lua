#!/usr/bin/lua5.3

lgi = require 'lgi'

gtk = lgi.Gtk
pixbuf = lgi.GdkPixbuf.Pixbuf

gtk.init()

bld = gtk.Builder()
bld:add_from_file('lab-4_krivosheev.glade')

ui = bld.objects

function ui.btn_add:on_clicked(...)
	name = ui.txt_name.txt
	value = tonumber(ui.txt_value.text)

	px = pixbuf.new_from_file('img-bluebery.png')

	i = ui.mdl_items:append()
	ui.mdl_items[i] = {[1] = name, [2] = value, [3] = px}
end

rdr_txt = gtk.CellRendererText {}
rdr_pix = gtk.CellRendererPixbuf {}


