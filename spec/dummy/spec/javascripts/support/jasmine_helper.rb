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

Jasmine.configure do |config|
  config.show_console_log = true
end

puts 'To skip installation pass rake jasmine PASS_INSTALL=true'

unless ENV["PASS_INSTALL"]
  system('bundle exec rails d marionette:install')
  system('bundle exec rails g marionette:install')

  system("rails g marionette:view TestLayout1 Layout")
  system("rails g marionette:view TestLayout2 Layout")
  system("rails g marionette:view TestLayout3 Layout")

  system("rails g marionette:view TestItemView1 ItemView title:string description:text url:text phone:string quantity:integer float_number:float decimal_number:decimal full:boolean email:string password:string")
  system("rails g marionette:view TestItemView2 ItemView")
  system("rails g marionette:view test_module/TestItemView3 ItemView")
  system("rails g marionette:view TestSubsubmodule/test_submodule/TestModule/testItemView4 ItemView")

  # system("rails g marionette:view TestCollectionView1 CollectionView")
  # system("rails g marionette:view admin/TestCollectionView2 CollectionView")
  # system("rails g marionette:view TestSubsubmodule/test_submodule/TestModule/TestCollectionView3 CollectionView")

  # system("rails g marionette:view TestCompositeView1 CompositeView")
  # system("rails g marionette:view test_module/TestCompositeView2 CompositeView")
  # system("rails g marionette:view TestSubsubmodule/test_submodule/TestModule/testCompositeView3 CompositeView")
end
