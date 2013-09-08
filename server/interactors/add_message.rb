require './repository'
require './repositories/memory'
require './repositories/memory_repositories/models/message'
require './interactors/broadcast_message'

class AddMessage

	def self.add_message(params)
		message = Repository.for(Message).save(Message.new(params[:message]))
		BroadcastMessage.broadcast_message(message, params[:socket_id])
		message
	end

end