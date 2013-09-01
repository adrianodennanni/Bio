#!/usr/bin/ruby
# This script create the tables for SocialStream project
# Don't change this script if you want to add a row on some table. Change config.yml
# Remember: This script don't create the database, just the tables
require 'mysql'
require 'yaml'

begin
  APP_CONFIG = YAML.load_file("../config.yml")

  host = APP_CONFIG['HOST_MYSQL']
  user = APP_CONFIG['LOGIN_MYSQL']
  pass = APP_CONFIG['PASSWORD_MYSQL']
  database = APP_CONFIG['DATABASE_MYSQL']

  connection = Mysql.new host, user, pass, database
  connection.query("CREATE TABLE IF NOT EXISTS User(#{APP_CONFIG['USER_TABLE_CREATE']}, PRIMARY KEY(#{APP_CONFIG['PK_USER_TABLE']}))")
  connection.query("CREATE TABLE IF NOT EXISTS Tweet(#{APP_CONFIG['TWEET_TABLE_CREATE']}, PRIMARY KEY(#{APP_CONFIG['PK_TWEET_TABLE']}))")
  connection.query("ALTER TABLE Tweet ADD CONSTRAINT FK_#{APP_CONFIG['FK_TWEET_TABLE']} FOREIGN KEY (#{APP_CONFIG['FK_TWEET_TABLE']}) REFERENCES User(#{APP_CONFIG['PK_USER_TABLE']}) ON UPDATE NO ACTION ON DELETE NO ACTION")

end
