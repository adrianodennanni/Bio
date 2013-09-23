#!/bin/bash
# This script will create the database "bio" in Linux computers
# Created by J. H. Kersul

echo "This script will create the database 'bio'"
echo "You will have to write your password 4 times"
sleep 2
mysql -u root -p -e "CREATE DATABASE bio;"
mysql -u root -p -e "CREATE USER bio@localhost IDENTIFIED BY 'poli';"
mysql -u root -p -e "USE bio;"
mysql -u root -p -e "GRANT ALL ON bio.* to bio@localhost;"
