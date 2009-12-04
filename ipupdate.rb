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
require 'cgi'

# Configuration
USERNAME='username'   
PASSWORD='secret'
HOST='owomi.com'

host = Net::HTTP.new("www.dnsexit.com", 80)
url = "/RemoteUpdate.sv?login=#{CGI.escape(USERNAME)}" +
      "&password=#{CGI.escape(PASSWORD)}" +
      "&host=#{CGI.escape(HOST)}"

resp, data = host.get(url, nil)
puts data
