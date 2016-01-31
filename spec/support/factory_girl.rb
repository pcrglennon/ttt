require 'factory_girl'

Dir['./spec/factories/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) { FactoryGirl.lint }
end
