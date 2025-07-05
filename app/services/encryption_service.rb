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

    # Convert hex to binary key
    key = [secret].pack("H*")
    unless key.bytesize == 32
      raise "Key must be 32 bytes, but got #{key.bytesize} bytes"
    end

    ActiveSupport::MessageEncryptor.new(key)
  end
end
