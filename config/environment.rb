# config/environment.rb

# Load the Rails application.
require_relative "application"

# Only add this block if you really need encryption setup here
if ENV["ENCRYPTION_SECRET"]
    require "openssl"
    raw_key = ENV["ENCRYPTION_SECRET"]
    @secret = raw_key.byteslice(0, 16)
    cipher = OpenSSL::Cipher.new('AES-128-CBC')
    cipher.encrypt
    cipher.key = @secret

end

# Initialize the Rails application.
Rails.application.initialize!