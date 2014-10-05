# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails4::Application.initialize!

ActiveRecord::ConnectionAdapters::Mysql2Adapter::NATIVE_DATABASE_TYPES[:long_primary_key] = "BIGINT(20) DEFAULT NULL auto_increment PRIMARY KEY"