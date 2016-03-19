require 'fepath/version'
require 'fepath/gid'
require 'fepath/attribute_extractor'
require 'fepath/structured_to_md'
require 'fepath/item'
require 'fepath/importer/path'
require 'fepath/importer/container'
require 'fepath/importer/reader'
require 'fepath/path_converter'
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
