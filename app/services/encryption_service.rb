# app/services/encryption_service.rb
require 'active_support/message_encryptor'

class EncryptionService
    def self.encrypt(message)
      encryptor.encrypt_and_sign(message)
    end
  
    def self.decrypt(ciphertext)
      encryptor.decrypt_and_verify(ciphertext)
    end
  
    def self.encryptor
      secret = ENV.fetch("ENCRYPTION_SECRET") do
        raise "Missing ENV: ENCRYPTION_SECRET"
      end
  
      raise "ENCRYPTION_SECRET must be 64 hex characters" unless secret.match?(/\A[0-9a-f]{64}\z/i)
  
      key = [secret].pack("H*") # => 32 bytes
      raise "Key must be 32 bytes, got #{key.bytesize}" unless key.bytesize == 32
  
      ActiveSupport::MessageEncryptor.new(key)
    end
  end