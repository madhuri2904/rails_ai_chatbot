require 'openssl'

ENCRYPTION_SECRET = ENV.fetch('ENCRYPTION_SECRET') do
  raise "ENCRYPTION_SECRET not set!"
end

unless ENCRYPTION_SECRET.length == 16
  raise ArgumentError, "ENCRYPTION_SECRET must be exactly 16 characters, got #{ENCRYPTION_SECRET.length}"
end

CIPHER = OpenSSL::Cipher.new('AES-128-ECB')
CIPHER.encrypt
CIPHER.key = ENCRYPTION_SECRET
