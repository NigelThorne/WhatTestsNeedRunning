# app.rb
require 'sinatra'
require 'builder'

set :port, 3333
# In your main application file
# configure do
#   set :views, "#{File.dirname(__FILE__)}/views"
#   set :public, "#{File.dirname(__FILE__)}/public"
# end


@@next_id = 1
@@all_tests = {}

post '/tests' do 
  @@all_tests[@@next_id] = params
  @@next_id+=1
  test_xml(params, xml())
end

# TODO: add tests then add this code if it's right
# get '/tests/:id' do 
#   test = @@all_tests[params["id"].to_i]
#   test_xml(test, xml())
# end

# delete '/tests/:id' do 
#   test = @@all_tests[params["id"].to_i]
#   test_xml(test, xml())
# end

get '/pending' do
  content_type 'text/xml'
  tests_xml(@@all_tests.to_a, xml())
end

def xml()
  xml = Builder::XmlMarkup.new( :indent => 2 )
  xml.instruct! :xml, :encoding => "ASCII"
  xml
end

def tests_xml(tests, scope)
	scope.tests do |xtests|
		tests.each{ |index, test|
			test_xml(test.merge({id:index}), xtests)
		}
	end
end

def test_xml(test, scope)
	scope.test(id:test[:id]) do |xtest|
		xtest.name test[:name]
		xtest.environment test[:environment]
	end
end
