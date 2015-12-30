RSpec.configure do |config|

  DatabaseCleaner.strategy = :truncation, {:only => %w[assets organizations organization_types sign_standards sign_standard_types]}
  config.before(:suite) do
    begin
      DatabaseCleaner.start
    ensure
      DatabaseCleaner.clean
    end
  end
end
