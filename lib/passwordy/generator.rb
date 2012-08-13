require 'digest'
require 'securerandom'

module Passwordy
  class Generator
    def self.environment_info
      ENV.map {|k,v| "#{k}=#{v}"}.join('&')
    end

    def self.generate_salt
      Digest::SHA512.hexdigest(environment_info + SecureRandom.uuid)
    end

    def self.write_salt(path)
      return if File.exists?(path)
      File.open(path, 'w') do |f|
        f.write(generate_salt)
        f.chmod(0400)
      end
    end

    def self.generate_password(domain, master_password)
      salt_path = File.expand_path('~/.salt')
      write_salt(salt_path)

      salt = File.open(salt_path, 'r').read

      first_digest = Digest::SHA512.hexdigest([salt, domain].join('\n'))
      second_digest = Digest::SHA512.hexdigest(master_password)
      digested_parts = [first_digest, second_digest].join('\n')

      Digest::SHA512.hexdigest(digested_parts)[1..32]
    end
  end
end
