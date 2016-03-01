module Importer
  class Path
    attr_reader :filepath, :author
    ALLOWED_TO_CREATE = %w{ Lesson Assignment }
    # TODO: This feels like strong params/ attr_accessible, possible tie into
    # controller facing params code, and sterilize that way.
    WHITELIST_ARGS = %w{ title description body }

    def initialize(filepath)
      @filepath = filepath
    end

    def attributes
      container.attributes
    end

    def container
      @container ||= Container.new(filepath).read
    end

    def units
      @units ||= container.children["unit"]
    end


    # Create a Path, all the way to lessons and assignments, wrapping all creates
    # in a single transaction to ensure failure in job does not pollute data
    #
    # Folder format
    # project
    #   - meta.yml
    #   unit_1
    #     -meta.yml
    #     1_lets_teach.md
    #     2_lets_give_out_homework.md
    #
    # meta.yml / Frontmatter are parsed as yaml and are sanitized and injected
    # as attributes to the thing being created
    #
    # Titles and such for individual lessons are extracted from front matter in
    # each file.
    #
    # returns

    def to_json
      { attributes['id'] => @container.to_json }
    end
  end
end
