require 'socket'
require 'openssl'
require 'base64'

license_key_file = '/usr/share/PracticalTraining/License/license_key'
license_file = '/usr/share/PracticalTraining/License/license'
passphrase = 'Practical Training 2013'

encrypted_string = File.read(license_file)

private_key = OpenSSL::PKey::RSA.new(File.read(license_key_file), passphrase)
decrypted_license = private_key.private_decrypt(Base64.decode64(encrypted_string))
licensed_host = decrypted_license.lines.first
licensed_ip = decrypted_license

local_host = Socket.gethostname
local_ips = Socket.ip_address_list


