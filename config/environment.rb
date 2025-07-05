# Load the Rails application.
require_relative "application"

if Rails.env.production?
  require "openssl"
  cipher = OpenSSL::Cipher.new('aes-128-cbc')
  cipher.encrypt

  key = ENV['ENCRYPTION_SECRET']

  unless key && key.bytesize == 16
    raise "ENCRYPTION_SECRET must be exactly 16 bytes. Set it in Render Environment Variables."
  end

  cipher.key = key
end

# Initialize the Rails application.
Rails.application.initialize!
