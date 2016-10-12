require 'socket'

module ServerHere
  IP = Socket.ip_address_list.select do |ad|
         ad.ipv4? && ad.getnameinfo[0] != 'localhost'
       end.first.ip_address
end
