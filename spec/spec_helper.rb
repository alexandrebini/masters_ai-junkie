# test support
Dir[File.dirname(__FILE__) + '/support/*.rb'].each {|file| require file }

# libs
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }

