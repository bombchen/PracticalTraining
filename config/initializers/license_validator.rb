# encoding:utf-8

require_relative '../../lib/mysigar.jar'
require 'socket'
require 'openssl'
require 'base64'
require 'rbconfig'
include Config

java_import Java::com.shixun.SystemInfo

def is_windows?
  return (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RbConfig::CONFIG['host_os']) != nil
end

license_folder = is_windows? ? 'c:\\PracticalTraining\\License\\' : '/usr/share/PracticalTraining/License/'
license_key_file = license_folder + 'license_key'
license_file = license_folder + 'license'
passphrase = 'Practical Training 2013'

if (!File.exists?(license_key_file))
  raise 'license_key file not found in '+license_key_file
end
if (!File.exists?(license_file))
  raise 'license file not found in '+license_file
end

encrypted_string = File.read(license_file)

private_key = OpenSSL::PKey::RSA.new(File.read(license_key_file), passphrase)
decrypted_license = private_key.private_decrypt(Base64.decode64(encrypted_string))
arr = decrypted_license.split("\n")

licensed_cpuModel = arr[0]
licensed_address = arr[1]

local_cpuModel = SystemInfo.getCpuModel
local_addresses = SystemInfo.getMacAddress

if (!licensed_cpuModel.eql?(local_cpuModel))
  raise 'not licensed to this server'
end

puts licensed_address
if (!local_addresses.include? licensed_address)
  raise 'no licensed IP found in this server'
end