#!/usr/bin/sh

rm -f lab-6_krivosheev_sdb.db
cat lab-6_krivosheev_sdb.sql | sqlite3 lab-6_krivosheev_sdb.db

lua5.3 lab-6_krivosheev_sdb.lua
