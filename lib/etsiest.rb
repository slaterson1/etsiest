require "pry"
require "etsiest/version"
require "etsy"
require "sinatra/base"
Etsy.api_key = ENV['ETSY_KEY']

module Etsiest

# Etsy.api_key = ENV['ETSY_KEY']

	class App < Sinatra::Application
		get '/search' do
			# binding.pry
			query = params['q']
			# if for missing"q"
			response = Etsy::Request.get('/listings/active', :includes => ['Images', 'Shop'], :keywords => query)
			items = response.result
			# binding.pry		
			erb :index, locals: {results: items}
	
			items = []
        	response.result.each do |item|
          		data = {}
          		data[:image] = item["Images"][0]["url_75x75"]
          		items << data
			end
		erb :index, locals: {results: items}
		end
	run! if app_file == $0
	end
end	