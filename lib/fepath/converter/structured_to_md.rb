require "yaml"
class StructuredToMarkdown
  def initialize(string = "")
    @data = {}
    @body = string
  end

  def add_header(name:, level:)
    self << [('#' * level.to_i), name].join(" ")
  end

  def <<(string)
    @body += (string + "\n\n") unless string.blank?
  end

  def add_checklist(name:, complete:)
    self << ["- [#{complete ? 'x' : ' '}]", name].join(" ")
  end

  def add_link(name:, url:)
    self << ["[#{name}]", "(#{url})"].join("")
  end

  def add_front_matter(args)
    @data.merge!(args)
  end

  def body
    if !@data.keys.empty?
      @body.prepend(@data.stringify_keys.to_yaml + "---\n")
    else
      @body
    end
  end
end
