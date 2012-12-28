require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :database => "appdb",
  :username => "appuser",
  :password => "secret"
)
