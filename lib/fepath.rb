require 'fepath/version'

require 'fepath/extractor/gid'
require 'fepath/extractor/attribute_extractor'

require 'fepath/converter/structured_to_md'
require 'fepath/converter/item'
require 'fepath/converter/path_converter'

require 'fepath/importer/path'
require 'fepath/importer/container'
require 'fepath/importer/reader'

require 'logger'
require 'dotenv'

Dotenv.load

module Fepath
  @logger = Logger.new(STDOUT)
  @logger.level = Logger::DEBUG

  def self.logger
    @logger
  end
end

class String
  def sterilize
    chomp.downcase.gsub(/[\/\&]/, '_and_').gsub(/\W+/, '_').gsub(/(__)+/, '_')
  end
end
