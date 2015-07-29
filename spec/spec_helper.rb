### ENV ####
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'spork'

Spork.prefork do
  RSpec.configure do |config|

    config.expect_with :rspec do |expectations|
      expectations.syntax = :expect
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    end

    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = true
    end

    ### MATCHERS AND HELPERS ###
    config.include FactoryGirl::Syntax::Methods
    # config.include Capybara::DSL
    # reinclude rspec matchers to override override Capybara `#all` method
    config.include RSpec::Matchers.clone
    Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }


  end
end

Spork.each_run do

end


