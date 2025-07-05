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

    # 32-byte key (64 hex chars)
    key = [secret].pack("H*")
    ActiveSupport::MessageEncryptor.new(key, cipher: 'aes-256-gcm')
  end
end
