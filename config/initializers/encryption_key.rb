require 'active_support/message_encryptor'

raw_secret = ENV['ENCRYPTION_SECRET']

raise "Missing ENCRYPTION_SECRET!" if raw_secret.blank?

# Derive a 256-bit key (32 bytes) for AES encryption using a salt
key = ActiveSupport::KeyGenerator.new(raw_secret).generate_key('salt', 32)

# Create a global encryptor constant
ENCRYPTOR = ActiveSupport::MessageEncryptor.new(key)