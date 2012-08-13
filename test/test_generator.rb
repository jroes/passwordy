require 'helper'
require 'tempfile'

class TestGenerator < Test::Unit::TestCase
  should "should not overwrite the salt if it already exists" do
    original_salt_file = Tempfile.new('salt')
    salt_path = original_salt_file.path
    original_salt_file.write('hello world')
    original_salt_file.close

    Generator.write_salt(salt_path)
    salt_file = File.open(salt_path, 'r')
    contents = salt_file.read
    salt_file.close
    assert_equal contents, 'hello world'
    original_salt_file.unlink
  end

  should "should write the salt if it doesn't exist yet" do
    temp_salt = Tempfile.new('salt')
    salt_path = temp_salt.path
    temp_salt.close
    temp_salt.unlink
    Generator.write_salt(salt_path)
    assert File.exists?(salt_path)
  end

  should "should generate the same password the second time around" do
    first = Generator.generate_password('google.com', 'hello world')
    second = Generator.generate_password('google.com', 'hello world')
    assert_equal first, second
  end

  should "should not generate the same password for different domains" do
    first = Generator.generate_password('google.com', 'hello world')
    second = Generator.generate_password('github.com', 'hello world')
    assert_not_equal first, second
  end
end
