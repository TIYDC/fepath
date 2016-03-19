require 'fepath/version'
require 'fepath/gid'
require 'fepath/attribute_extractor'
require 'fepath/structured_to_md'
require 'fepath/item'
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
  def trelloize
    chomp.downcase.gsub(/[,!@#$%^*()]/, '_').gsub(/\s+/, '_').gsub(/[\/\&]/, '_and_')
  end
end
