APP_ROOT = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(APP_ROOT, 'lib'))

require 'app'

App.new.launch!
