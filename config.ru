require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

# Which environment are we in?
puts "\n**********\nCurrent environment: #{ENV['APP_ENV']}\n***********\n"

run ApplicationController
