# TODO: Upload attachments, ... append links to MD?

module Importer
  class Container
    attr_accessor :dir, :attributes, :children

    DEFAULT_CONTAINER_TYPE = "unit".freeze
    DEFAULT_DOC_TYPE = "attachment".freeze
    META_FILENAME = "meta".freeze
    REJECT_FILENAMES = [".DS_Store"]

    def initialize(dir)
      @dir = dir
      @children = {}
    end

    def read
      Dir.glob(File.join(File.expand_path(dir), "*") ) do |f|
        puts f
        next if REJECT_FILENAMES.include?(File.basename(f))
        if File.file?(f)
          handle_file(f)
        elsif File.directory?(f)
          handle_dir(f)
        end
      end

      return self
    end

  private

    def extract_meta(file)
      self.attributes = case File.extname(file)
                        when ".yml"
                          YAML.load(File.read(file))
                        when ".json"
                          JSON.parse(File.read(file))
                        else
                          {}
                        end
    end

    def handle_file(file)
      if File.basename(file).include?(META_FILENAME)
        extract_meta(file)
      else
        doc = Reader.new(file).read
        store_child((doc.attributes["type"] || DEFAULT_DOC_TYPE) , doc)
      end
    end

    def handle_dir(dir)
      child = self.class.new(dir).read
      store_child((child.attributes["type"] || DEFAULT_CONTAINER_TYPE), child)
    end

    def store_child(type, obj)
      children[type] ||= []
      children[type] << obj
    end
  end
end
