RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # require capybara
  # SEE ALSO:
  # http://app2641.hatenablog.com/entry/2014/12/15/172954
  # http://qiita.com/ori_ika/items/ded35722b9f22d02d988
  ENV['RAILS_ENV'] = 'test'
  require File.expand_path('../../config/environment', __FILE__)
  config.include Capybara::DSL

  Capybara.configure do |config|
    config.run_server = false
    config.current_driver = :selenium
    config.app_host = 'http://0.0.0.0:3000/'
  end
end
