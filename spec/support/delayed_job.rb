RSpec.configure do |config|
  config.before do
    Delayed::Worker.delay_jobs = false
  end
end
