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
      raise "ENCRYPTION_SECRET environment variable is not set"
    end

    key = ActiveSupport::KeyGenerator.new(secret).generate_key("salt", 32)
    ActiveSupport::MessageEncryptor.new(key)
  end
end