class Entry
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :content

  def initialize(options={})
    @path = File.join Wiki.repo_dir, options[:url]
    @raw_content = find_or_create_file

    @content = parse_file[1]
    @yaml = YAML.parse parse_file[2] if parse_file[2]

    @content = options[:content] if options[:content] 
  end

  def find_or_create_file
    file = File.open @path, 'r'
    file.read
  end

  def parse_file
    @raw_content.match(/^(.+)-----(.+)-----/m)
  end

  def save
    if @content
      File.open(@path, 'w'){|f| f.write @content}
    else
      raise NothingToSaveError
    end
  end

end

class NothingToSaveError < StandardError; end
