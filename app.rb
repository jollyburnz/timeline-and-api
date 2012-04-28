require 'sinatra'
require 'coffee-script'
require 'httparty'
require 'json_builder'
require 'json'
require 'pp'

class Meetup
	include HTTParty
	format :json
	default_params :output => 'json'

	def self.events
		get("https://api.meetup.com/events?key=e65a3a6c7f5b2daf1b615c7c3846&sign=true&group_id=1768544&page=20")
	end
end

get '/application.js' do
	coffee :application
end

get '/' do
	File.open('public/index.html')
end

get '/meetup' do
	resp = HTTParty.get("https://api.meetup.com/2/events?key=e65a3a6c7f5b2daf1b615c7c3846&sign=true&group_urlname=relitny&page=20")
	@json = JSONBuilder::Compiler.generate do
		timeline do
			headline resp['meta']['title']
			type 'default'
			startDate '2011,9,1'
			text resp['meta']['description']
			asset do
				media ''
				credit ''
				caption ''
			end
			date resp['results'] do |a|
				startDate Time.at(a['time'].to_s[0..-4].to_i).strftime("%Y,%m,%d")
				headline a['name']
				text a['description'].to_s
				asset do
					#media "http://maps.google.com/maps?ll="+a['venue']['lat'].to_s+","+a['venue']['lon'].to_s
					media ""
					credit 'google maps'
					caption a['venue']['address_1']
				end
			end
		end
	end
	@json
end

get '/test' do
	resp = HTTParty.get("http://www.nyartbeat.com/list/event_mostpopular.en.xml", :format => :xml)
	
	@xml = JSONBuilder::Compiler.generate do
		timeline do
			headline "asdfdS"
			type 'default'
			startDate "2011,9,1"
			text "hello"
			asset do
				media ''
				credit ''
				caption ''
			end
			date resp['Events']['Event'] do |a|
				startDate a['DateStart'].gsub(/-/, ',').gsub(/,0/, ',')
				headline a['Name'].gsub(/"/,'')
				text a['Description']
				asset do
					media a['Image'][2]['src']
					credit ""
					caption a["Price"]
				end
			end
		end
	end
	@xml
end

