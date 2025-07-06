# config/environment.rb

# Load the Rails application.
require_relative "application"

# Optional encryption setup
if ENV["ENCRYPTION_SECRET"]
  require "openssl"

  raw_key = ENV["ENCRYPTION_SECRET"].to_s.byteslice(0, 16)

  # Ensure exactly 16 bytes for AES-128
  if raw_key.bytesize != 16
    raise ArgumentError, "ENCRYPTION_SECRET must be at least 16 bytes (got #{trimmed_key.bytesize})"
  end

  cipher = OpenSSL::Cipher.new('AES-128-CBC')

  cipher.encrypt
  cipher.key = raw_key

  # Make @secret available globally if needed
  @secret = raw_key
else
    raise "ENCRYPTION_SECRET is not set!"
end

# Initialize the Rails application.
Rails.application.initialize!
