require 'net/http'
require 'uri'

class BroadcastMessage

	def self.broadcast_message(message, socket_id)
		unless socket_id.nil? || socket_id.empty?
			uri = URI.parse("http://localhost:3000/api/broadcast")

			http = Net::HTTP.new(uri.host, uri.port)

			request = Net::HTTP::Post.new(uri.request_uri)
			request.set_form_data( { "message" => message.message, "message_id" => message.id, "origin_socket" => socket_id } )

			http.request(request)
		end
	end

end