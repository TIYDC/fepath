class PathConverter
  def initialize(json)
    @path = OpenStruct.new(json.symbolize_keys)
  end

  def units
    @path.units
  end

  def to_json
    JSON.pretty_generate(@path.to_h.except(:units))
  end

  def to_dir(dest:)
    @destination = dest
    units.each_with_index do |unit, i|
      ContainerConverter.new(dest: dest, container: unit, index: i).convert
    end
    File.write(File.join(@destination, 'meta.json'), to_json)
  end
end
