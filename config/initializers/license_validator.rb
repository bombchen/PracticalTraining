require 'socket'
require 'openssl'
require 'base64'

license_key_file = '/usr/share/PracticalTraining/License/license_key'
license_file = '/usr/share/PracticalTraining/License/license'
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
licensed_host = arr[0]
licensed_ip = arr[1]

local_host = Socket.gethostname
local_ips = Socket.ip_address_list.find_all{|intf| intf.ipv4?}

if (!licensed_host.eql?(local_host))
  raise 'not licensed to this server'
end

ip_verified = false
local_ips.each do |ip|
  strip = ip.ip_address
  if (strip.eql?(licensed_ip))
    ip_verified = true
  end
end

if (!ip_verified)
  raise 'no licensed IP found in this server'
end