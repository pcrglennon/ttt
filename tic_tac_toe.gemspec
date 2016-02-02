# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tic_tac_toe/version'

Gem::Specification.new do |spec|
  spec.name          = "tic_tac_toe"
  spec.version       = TicTacToe::VERSION
  spec.authors       = ["Peter Glennon"]
  spec.email         = ["pcrglennon@gmail.com"]

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "factory_girl", "~> 4.0"
end
