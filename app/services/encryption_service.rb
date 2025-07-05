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

    # Convert hex key to binary (32 bytes)
    key = [secret].pack("H*")
    ActiveSupport::MessageEncryptor.new(key)
  end
end