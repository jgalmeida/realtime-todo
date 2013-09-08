class Repository

  def self.configure(options = {})
    @mappings ||= {}
    @mappings.merge!(options)
  end

  def self.reset!
    @mappings = {}
  end

  def self.for(klass)
    @mappings[klass] || @mappings[klass.to_s]
  end

end