require 'digest'
require 'securerandom'

module Passwordy
  class Generator
    # Public: Write a salt file to a particular location.
    #
    # path - The String path to save the salt.
    #
    # Does not overwrite an existing file at the given location.
    def self.write_salt(path)
      return if File.exists?(path)
      File.open(path, 'w') do |f|
        f.write(generate_salt)
        f.chmod(0400)
      end
    end

    # Public: Generate a password for a given resource.
    #
    # resource -        The String name of the thing we want a
    #                   password for.
    # master_password - The String master password that is used to
    #                   generate any subsequent passwords.
    #
    # Examples
    #
    #   generate_password('google.com', 'keyboard cat')
    #   # => 'e94e5ce8c8ca9affb507ae9e152d4b44'
    #
    # Returns a password that can be used for the given resource.
    def self.generate_password(resource, master_password, len=23)
      salt_path = File.expand_path('~/.salt')
      write_salt(salt_path)

      salt = File.open(salt_path, 'r').read

      sha_a = Digest::SHA512.digest(salt).bytes
      sha_b = Digest::SHA512.digest(resource).bytes
      sha_c = Digest::SHA512.digest(master_password).bytes

      Digest::SHA512.base64digest(sha_a.zip(sha_b,sha_c).map{|a,b,c| a ^ b ^ c }.pack("C*"))[1..len] #>128 bits of entropy
    end

    private

    def self.environment_info
      ENV.map {|k,v| "#{k}=#{v}"}.join('&')
    end

    def self.generate_salt
      Digest::SHA512.hexdigest(environment_info + SecureRandom.uuid)
    end
  end
end
