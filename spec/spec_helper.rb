$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tic_tac_toe'

Dir['./spec/support/**/*.rb'].each { |f| require f }
