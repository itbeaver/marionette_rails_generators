require 'coffee_script'
#Use this file to set/override Jasmine configuration options
#You can remove it if you don't need it.
#This file is loaded *after* jasmine.yml is interpreted.
#
#Example: using a different boot file.
#Jasmine.configure do |config|
#   config.boot_dir = '/absolute/path/to/boot_dir'
#   config.boot_files = lambda { ['/absolute/path/to/boot_dir/file.js'] }
#end
#
#Example: prevent PhantomJS auto install, uses PhantomJS already on your path.
#Jasmine.configure do |config|
#   config.prevent_phantom_js_auto_install = true
#end
#
system('bundle exec rails d marionette:install') if File.exist? 'app/assets/javascripts/backbone/app.js.coffee'
system('bundle exec rails g marionette:install')
