# config/environment.rb

# Load the Rails application.
require_relative "application"

# Optional encryption setup
if ENV["ENCRYPTION_SECRET"]
  require "openssl"

  raw_key = ENV["ENCRYPTION_SECRET"]

  # Ensure exactly 16 bytes for AES-128
  trimmed_key = raw_key.byteslice(0, 16)
  if trimmed_key.bytesize != 16
    raise ArgumentError, "ENCRYPTION_SECRET must be at least 16 bytes (got #{trimmed_key.bytesize})"
  end

  cipher = OpenSSL::Cipher.new('AES-128-CBC')

  cipher.encrypt
  cipher.key = trimmed_key

  # Make @secret available globally if needed
  @secret = trimmed_key
end

# Initialize the Rails application.
Rails.application.initialize!
