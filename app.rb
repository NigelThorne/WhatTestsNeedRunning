# app.rb
require 'sinatra'
require 'builder'

set :port, 3333
# In your main application file
# configure do
#   set :views, "#{File.dirname(__FILE__)}/views"
#   set :public, "#{File.dirname(__FILE__)}/public"
# end

@@all_items = []

post '/add' do 
  @@all_items << (params)
  xml = Builder::XmlMarkup.new( :indent => 2 )
  xml.instruct! :xml, :encoding => "ASCII"
  item_xml(xml, params)
end

get '/pending' do
  content_type 'text/xml'
  items_xml(@@all_items)
end

def items_xml(items)
  xml = Builder::XmlMarkup.new( :indent => 2 )
  xml.instruct! :xml, :encoding => "ASCII"
  xml.items do |xitems|
	items.each_with_index{ |item, index|
		item_xml(xitems, item.merge({id:index+1}))
	}
  end
end

def item_xml(scope, item)
	scope.item(id:item[:id]) do |xitem|
#		xitem[:id]= item[:id]
		xitem.name item[:name]
		xitem.environment item[:environment]
	end
end
