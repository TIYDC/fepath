require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'

require 'logger'
require 'dotenv'
require 'fileutils'
require 'open-uri'

Dotenv.load

require 'fepath/version'

require 'fepath/extractor/gid'
require 'fepath/extractor/attribute_extractor'

require 'fepath/converter/structured_to_md'
require 'fepath/converter/item'
require 'fepath/converter/path_converter'
require 'fepath/converter/container_converter'

require 'fepath/importer/path'
require 'fepath/importer/container'
require 'fepath/importer/reader'

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
