class ContainerConverter
  attr_reader :destination, :index, :container
  def initialize(container:, dest:, index: )
    data = container[container.keys.first].symbolize_keys
    @container = OpenStruct.new(data)
    @destination = dest
    @index = index + 1
  end

  def path
    children? ? folder_path : file_path
  end

  def folder_path
    File.join(destination, "#{index}_#{container.title.to_s.sterilize}")
  end

  def file_path
    File.join(destination, "#{index}_#{container.title.sterilize}.md")
  end

  def children
    container.children || []
  end

  def children?
    !children.empty?
  end

  def attachments
    container.attachments || []
  end

  def attachments?
    !attachments.empty?
  end

  def convert
    if children?
      convert_containers!
    else
      convert_lesson_or_assignment!
    end
  end

  private

  def convert_containers!
    FileUtils.mkdir_p path
    children.each_with_index do |item, i|
      ContainerConverter.new(dest: path, container: item, index: i).convert
    end

    write_meta!(path, container.to_h.except(:children))
  end

  def convert_lesson_or_assignment!
    container.data = container.to_h.except(:body)

    @md = StructuredToMarkdown.new
    @md << container.body.to_s

    if attachments?
      FileUtils.mkdir_p path

      write_attachments!

      write_meta!(path, container.data)

      File.write(File.join(path, 'readme.md'), @md.body)
    else
      @md.add_front_matter(container.data)

      File.write(path, @md.body)
    end
  end

  def write_meta!(meta_path, data)
    File.write(File.join(meta_path, 'meta.json'), JSON.pretty_generate(data))
  end

  def write_attachments!
    attachments.each do |name, link|
      @md.add_link(name: name, url: link)
      Item.download_file(name: name, url: link, path: path)
    end
  end
end
