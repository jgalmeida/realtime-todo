require './repository'
require './repositories/memory'
require './repositories/memory_repositories/models/message'

class ListMessages

	def self.list_messages
		Repository.for(Message).all
	end

end