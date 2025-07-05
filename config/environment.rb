# Load the Rails application.
require_relative "application"

if Rails.env.production?
    require "openssl"
    cipher = OpenSSL::Cipher.new('aes-128-cbc')
    cipher.encrypt
  
    key = ENV['ENCRYPTION_SECRET']
  
    puts "🔐 ENV['ENCRYPTION_SECRET'] = #{key.inspect}"
    puts "🔐 Length = #{key&.bytesize}"
  
    unless key && key.bytesize == 16
      raise "ENCRYPTION_SECRET must be exactly 16 bytes. Got: #{key&.bytesize || 0}"
    end
  
    cipher.key = key
  end

# Initialize the Rails application.
Rails.application.initialize!
