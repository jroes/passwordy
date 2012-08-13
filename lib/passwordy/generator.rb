require 'digest'

module Passwordy
  class Generator
    def self.environment_info
      ENV.map {|k,v| "#{k}=#{v}"}.join('&')
    end

    def self.generate_salt
      Digest::SHA512.hexdigest(environment_info + SecureRandom.uuid)
    end

    def self.write_salt(path)
      File.new(path, 'w') do |f|
        f.write(generate_salt)
        f.chmod(0400)
      end
    end

    def self.generate_password(domain)
      salt_path = File.expand_path('~/.salt')
      write_salt unless File.exists?(salt_path)

      salt = File.open(salt_path, 'r').read

      `stty -echo`
      first_digest = Digest::SHA512.hexdigest([salt, domain].join('\n'))
      second_digest = Digest::SHA512.hexdigest($stdin.gets)
      digested_parts = [first_digest, second_digest].join('\n')
      `stty echo`

      Digest::SHA512.hexdigest(digested_parts).chars.to_a.last(32).join
    end
  end
end
