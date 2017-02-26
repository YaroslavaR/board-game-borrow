#!/bin/bash
bundle install
bin/rails db:migrate RAILS_ENV=development
echo "insert into users (email,name,is_admin,created_at,updated_at,encrypted_password) values ('admin@admin.ad','admin',1,'2017-02-25 20:47:38.749339','2017-02-25 20:47:38.749339','$2a$11$J1.wd62oHVO/o9DdeToJreMsaXatjivfI9bwFfG4M5G47Zzg2t4Om');" > create_admin.sql
sqlite3 db/development.sqlite3 < create_admin.sql
rm create_admin.sql
bin/rails server