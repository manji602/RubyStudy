require 'factory_girl_rails'
require 'capybara/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # require capybara
  # SEE ALSO:
  # http://app2641.hatenablog.com/entry/2014/12/15/172954
  # http://qiita.com/ori_ika/items/ded35722b9f22d02d988
  config.include Capybara::DSL

end
