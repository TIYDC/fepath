class Item
  class << self
    def download_file(name:, url:, path:)
      File.open(File.join(path, name), "wb") do |file|
        open(url, "rb") do |web_file|
          file.write(web_file.read)
        end
      end
    end
  end
end