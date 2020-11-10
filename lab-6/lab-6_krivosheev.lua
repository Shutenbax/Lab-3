#!/usr/bin/lua5.3

lgi = require 'lgi'
sqlite = require 'lsqlite3'

gtk = lgi.Gtk
pixbuf = lgi.GdkPixbuf.Pixbuf

gtk.init()

bld = gtk.Builder()
bld:add_from_file('lab-6_krivosheev.glade')

ui = bld.objects
ui.wnd.title = 'lab-6_krivosheev'

rdr_txt = gtk.CellRendererText {}
rdr_pix = gtk.CellRendererPixbuf {}

c1 = gtk.TreeViewColumn { title = 'Name', {rdr_txt, { text = 1 }}}
c2 = gtk.TreeViewColumn { title = 'Volue', {rdr_txt, { text = 2 }}}
c3 = gtk.TreeViewColumn { title = 'Image', {rdr_pix, { pixbuf = 3 }}}
c4 = gtk.TreeViewColumn { title = 'Sale', {rdr_txt, { text = 4 }}}

ui.lst_items:append_column(c1)
ui.lst_items:append_column(c2)
ui.lst_items:append_column(c3)
ui.lst_items:append_column(c4)


db = sqlite.open('lab-6_krivosheev.db')

for row in db:nrows('SELECT * FROM list') do
	px = pixbuf.new_from_file(row.image)
	print(row.name)
	el = ui.stor_items:append()
	ui.stor_items[el] = { [1] = row.name, [2] = row.volue, [3] = px, [4] = row.sale }
end

db:close()

--[[
local base = 'lab-04'
local sql = 'SELECT * FROM list'
f = io.popen('sqlite3 lab-6_krivosheev.db "lab-6_krivosheev.sql"')
while true do
	local row = f:read('*l')
	print(row)
	if row == nil then break end
	local _, _, name, volue, image, sale = row:find('(%w+)|(%d+)|(.-)|(%d+)$')
	px = pixbuf.new_from_file(image)
	el = ui.stor_items:append()
	ui.stor_items[el] = { [1] = row.name, [2] = row.volue, [3] = px, [4] = row.sale }
end
f:close()
]]
ui.wnd.on_destroy = gtk.main_quit
ui.wnd:show_all()

gtk.main()
