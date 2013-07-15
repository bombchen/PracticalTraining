# encoding: utf-8

require 'openssl'
require 'base64'

puts '请输入license_key.pub 文件路径:'
pub_file = gets.chomp
if(!File.exists?(pub_file))
  raise '文件不存在'
end
public_key = OpenSSL::PKey::RSA.new(File.read(pub_file))
puts '请输入服务器机器名:'
host = gets.chomp
puts '请输入服务器IP地址:'
ip = gets.chomp

source_license = host + "\n" + ip
encrypted_license = Base64.encode64(public_key.public_encrypt(source_license))

puts '请输入存放证书的文件夹:'
license_folder = gets.chomp
if(!File.exist?(license_folder))
  raise '目标文件夹不存在'
end
license_file = File.join(license_folder, 'license')

if(File.exists?(license_file))
  raise license_file + '已经存在, 请更换目标文件夹'
end

File.open(license_file, 'w') {|f| f.write(encrypted_license) }

puts 'license文件' + license_file + '已生成'