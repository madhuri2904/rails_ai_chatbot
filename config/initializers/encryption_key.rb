ENCRYPTION_SECRET = ENV['ENCRYPTION_SECRET']

if ENCRYPTION_SECRET.nil? || ENCRYPTION_SECRET.bytesize != 16
  raise ArgumentError, "ENCRYPTION_SECRET must be exactly 16 bytes. Please check your environment variable."
end

# Optional: Example Cipher usage
# cipher = OpenSSL::Cipher.new("AES-128-ECB")
# cipher.encrypt
# cipher.key = ENCRYPTION_SECRET
