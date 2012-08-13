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
    def self.generate_password(resource, master_password)
      salt_path = File.expand_path('~/.salt')
      write_salt(salt_path)

      salt = File.open(salt_path, 'r').read

      first_digest = Digest::SHA512.hexdigest([salt, resource].join('\n'))
      second_digest = Digest::SHA512.hexdigest(master_password)
      digested_parts = [first_digest, second_digest].join('\n')

      Digest::SHA512.hexdigest(digested_parts)[1..32]
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
