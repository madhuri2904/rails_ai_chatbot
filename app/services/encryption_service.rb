# app/services/encryption_service.rb
require 'openssl'
require 'base64'

class EncryptionService
  def self.encrypt(text)
    cipher = OpenSSL::Cipher.new('aes-128-cbc')
    cipher.encrypt

    key = ENV.fetch('ENCRYPTION_SECRET')
    raise "ENCRYPTION_SECRET must be 16 bytes" unless key.bytesize == 16

    cipher.key = key
    iv = cipher.random_iv

    encrypted = cipher.update(text) + cipher.final

    {
      data: Base64.encode64(encrypted),
      iv: Base64.encode64(iv)
    }
  end

  def self.decrypt(data, iv)
    decipher = OpenSSL::Cipher.new('aes-128-cbc')
    decipher.decrypt

    key = ENV.fetch('ENCRYPTION_SECRET')
    raise "ENCRYPTION_SECRET must be 16 bytes" unless key.bytesize == 16

    decipher.key = key
    decipher.iv = Base64.decode64(iv)

    decrypted = decipher.update(Base64.decode64(data)) + decipher.final
    decrypted
  end
end
