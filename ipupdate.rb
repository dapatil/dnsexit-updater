#!/usr/bin/ruby

#
# Dynamic DNS updater for http://dnsexit.com
#
# Author: Darshan Patil
# 
# Usage: stick this in your crontab and run this every 10 minutes
#
# My crontab entry looks like this
# */10 *  *   *   *    /path/to/ipupdate.rb
#
require 'net/http'
require 'socket'
require 'cgi'

# Configuration
USERNAME='username'   
PASSWORD='secret'
HOST='owomi.com'

# Hits checkip.dyndns.com and finds out your external IP
def myIP
  svc = Net::HTTP.new("checkip.dyndns.com", 80)
  _, data = svc.get("/", nil)
  if data
    return data.match(/\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/).to_s
  else
    return nil
  end
end

# Returns current IP for HOST
def domainIP
  return Socket.getaddrinfo(HOST, 'http')[0][3]
end

# Update dnsexit
def updateDNS
  puts "IP change detected - Updating DNS"
  host = Net::HTTP.new("www.dnsexit.com", 80)
  url = "/RemoteUpdate.sv?login=#{CGI.escape(USERNAME)}" +
    "&password=#{CGI.escape(PASSWORD)}" +
    "&host=#{CGI.escape(HOST)}"

  resp, data = host.get(url, nil)
  puts data
end

if __FILE__ == $0
  updateDNS if myIP != domainIP
end
