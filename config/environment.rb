# config/environment.rb

# Load the Rails application.
require_relative "application"

raw_key = ENV["ENCRYPTION_SECRET"]
@secret = raw_key.byteslice(0, 16)
cipher.key = @secret


# Initialize the Rails application.
Rails.application.initialize!
