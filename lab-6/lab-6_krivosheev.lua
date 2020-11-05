#!/usr/bin/lua5.3

lgi = require 'lgi'
sqlite = require 'lsqlite3'

gtk = lgi.Gtk
pixbuf = lgi.GdkPixbuf.Pixbuf

gtk.init()

bld = gtk.Builder()
bld:add_from_file('lab-6_krivosheev.glade')

ui = bld.objects

rdr_txt = gtk.CellRendererText {}
rdr_pix = gtk.CellRendererPixbuf {}

c1 = gtk.TreeViewColumn { title = 'Name', {rdr_txt, { text = 1 }}}
c2 = gtk.TreeViewColumn { title = 'Value', {rdr_txt, { text = 2 }}}
c3 = gtk.TreeViewColumn { title = 'Image', {rdr_pix, { pixbuf = 3 }}}
c4 = gtk.TreeViewColumn { title = 'Sale', {rdr_txt, { text = 1 }}}

ui.lst_items:append_column(c1)
ui.lst_items:append_column(c2)
ui.lst_items:append_column(c3)
ui.lst_items:append_column(c4)

db = sqlite.open('lab-6_krivosheev.db')

for row in db:rows('SELECT * FROM list') do
	px = pixbuf.new_from_file(row.image)

	el = ui.stor_items:append()
	ui.stor_items[el] = { [1] = row.name, [2] = row.value, [3] = px, [4] = row.sale }
end

db:close()

ui.wnd.on_destroy = gtk.main_quit
ui.wnd:show_all()

gtk.main()
