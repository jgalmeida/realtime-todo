require 'sinatra'
require 'json'
require './repository'
require './repositories/memory'
require './interactors/list_messages'
require './interactors/add_message'

configure do
	Repository.configure( "Message" => Memory::MessageRepository.new )
end

get '/' do
	@messages = ListMessages.list_messages
 	erb :index
end

post '/messages' do
  content_type :json
	message = AddMessage.add_message(params)
	message.to_json.to_json
end