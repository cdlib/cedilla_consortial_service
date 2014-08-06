require 'rubygems'
require 'bundler'
require 'sinatra'
require 'sinatra/base'
require 'logger'
require 'yaml'
require 'cedilla'
require './consortial.rb'

configure do
  LOGGER = Logger.new("consortial.log")
  enable :logging, :dump_errors
  set :raise_errors, true
  
  set :environment, :development #ENV['RACK_ENV'].to_sym
  set :run, true
end

begin
  if File.exists?(File.dirname(__FILE__) + '/config/app.yml')
    $stdout.puts "Loading configuration file."
    CONFIG = YAML.load_file('./config/app.yml')
    
  else
    $stdout.puts "Warning: ./config/app.yml not found! Using ./config/app.yml.example instead."
    CONFIG = YAML.load_file('./config/app.yml.example')
  end
rescue Exception => e
  $stdout.puts "Unable to load configuration file, ./config/app.yml!"
  $stdout.puts "#{e.message}"
end

# -------------------------------------------------------------------------
run Consortial.new