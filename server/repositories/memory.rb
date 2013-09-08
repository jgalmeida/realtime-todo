module Memory

	class IndexedRepository
		def initialize
			@counter = 0
			@records = []
		end

		def all
			copy_and_return @records
		end

		def find(id)
			find_one { |e| r.id == id }
		end

		def find_one(&block)
			copy_and_return @records.find(&block)
		end

		def save(obj)
			@counter = @counter + 1
			obj.id = @counter
			@records.push obj
			obj
		end

		def delete(obj)
			@records.delete_if { |e| e.id == obj.id }
		end

		def copy_and_return(record_or_array)
			if record_or_array.nil?
				nil
			elsif record_or_array.is_a?(Array)
				record_or_array.map{ |e| copy_and_return(e) }
			else
				record_or_array.clone
			end
		end
	end

	class MessageRepository < IndexedRepository
	end

end