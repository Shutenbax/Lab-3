#!/usr/bin/lua5.3

lgi = require 'lgi'
sqlite = require 'lsqlite3'

gtk = lgi.Gtk
pixbuf = lgi.GdkPixbuf.Pixbuf

gtk.init()

bld = gtk.Builder()
bld:add_from_file('lab-6_krivosheev_sdb.glade')

ui = bld.objects
ui.wnd.title = 'lab-6_krivosheev_sdb'

rdr_txt = gtk.CellRendererText {}

c1 = gtk.TreeViewColumn { title = 'name', {rdr_txt, { text = 1 }}}
c2 = gtk.TreeViewColumn { title = 'nameLanguage', {rdr_txt, { text = 1 }}}

ui.lst_Programmer:append_column(c1)
ui.lst_Language:append_column(c2)


db = sqlite.open('lab-6_krivosheev_sdb.db')

for row in db:nrows('SELECT * FROM employee') do
	el = ui.employ:append()
	ui.employ[el] = { [1] = row.name}
end

for row in db:nrows('SELECT * FROM language') do
	el = ui.langue:append()
	ui.langue[el] = { [1] = row.nameLanguage}
end

function ui.TreeProg:on_changed(...)
	if (ui.TreeProg)

	i = ui.mdl_items:append()
	ui.langue[i] = {[1] = name, [2] = value, [3] = px, [4]=sale}
end



db:close()

ui.wnd.on_destroy = gtk.main_quit
ui.wnd:show_all()

gtk.main()
