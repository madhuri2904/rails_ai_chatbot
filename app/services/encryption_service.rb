# app/services/encryption_service.rb
class EncryptionService
    def self.encrypt(text)
      cipher = OpenSSL::Cipher.new('aes-128-cbc')
      cipher.encrypt
  
      key = ENV.fetch('ENCRYPTION_SECRET') do
        raise "Missing ENV['ENCRYPTION_SECRET']"
      end
  
      raise "Key must be 16 bytes" unless key.bytesize == 16
  
      cipher.key = key
      iv = cipher.random_iv
      encrypted = cipher.update(text) + cipher.final
  
      {
        encrypted: Base64.encode64(encrypted),
        iv: Base64.encode64(iv)
      }
    end
end
  