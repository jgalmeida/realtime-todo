class Message

	attr_accessor :id, :message

	def initialize(message)
		@message = message
	end

	def to_json
		{ :id => @id, :message => @message }
	end

end