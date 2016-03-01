module Importer
  class Reader
    attr_accessor :attributes, :content, :filepath

    YAML_FRONT_MATTER_REGEXP = /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m

    def initialize(filepath, attributes = {})
      @filepath = filepath
      @attributes = attributes
    end

    # Read in the file and assign the content and attributes based on the
    # file contents.
    #
    # Returns self.
    def read
      Fepath.logger.debug "Reading: #{filepath}"

      begin
        self.content = File.read(filepath)
        match_data = YAML_FRONT_MATTER_REGEXP.match(content)
        if match_data
          self.content = match_data.post_match
          self.attributes.merge!(YAML.load(match_data[1]))
        end
      rescue SyntaxError => e
        Fepath.logger.fatal "YAML Exception reading #{filepath}: #{e.message}"
      rescue Exception => e
        Fepath.logger.fatal "Error reading file #{filepath}: #{e.message}"
      end

      return self
    end
  end
end
