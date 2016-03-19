class PathConverter
  def initialize(json)
    @path = OpenStruct.new(json.symbolize_keys)
  end

  def units
    @units ||= @path.units.map { |u| OpenStruct.new(u.symbolize_keys) }
  end

  def to_dir(dest:)
    @destination = dest
    units.each_with_index do |unit, unit_i|
      unit_folder = File.join(@destination, "#{unit_i + 1}_#{unit.title.trelloize}")
      FileUtils.mkdir_p unit_folder
      (unit.children || []).each_with_index do |item, item_i|
        item = OpenStruct.new(item[item.keys.first].symbolize_keys)
        item.data = item.to_h.except(:body)

        @md = StructuredToMarkdown.new
        @md << item.body.to_s

        if item.attachments.length > 0
          item_folder = File.join(unit_folder, "#{item_i + 1}_#{item.title.trelloize}")
          FileUtils.mkdir_p item_folder

          # Extract Attachments
          item.attachments.each do |name, link|
            @md.add_link(name: name, url: link)
            Item.download_file(name: name, url: link, path: item_folder)
          end

          File.write(File.join(item_folder, 'meta.json'), JSON.pretty_generate(item.data))
          File.write(File.join(item_folder, 'readme.md'), @md.body)
        else
          @md.add_front_matter(item.data)
          File.write(File.join(unit_folder, "#{item_i + 1}_#{item.title.trelloize}.md"), @md.body)
        end
      end

      File.write("#{unit_folder}/meta.json", unit.to_h.to_json)
    end
    File.write(File.join(@destination, 'meta.json'), @path.to_h[:path].to_json)
  end
end
