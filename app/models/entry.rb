class Entry
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :file_name, :content, :yaml_data, :images, :files, :assets

  def initialize(options = {})
    if options[:file_name]
      @file_name = options[:file_name]
      @path = File.join Wiki.repo_dir, "#{options[:file_name]}.markdown"
      @raw_content = find_or_create_file

      @content = parse_file[1]
      @yaml_data = YAML.load parse_file[2]
    end

    @content   = options[:content] if options[:content] 
    @assets    = MetaData.deserialize_assets(self) || []
  end

  def self.all
    Dir.chdir Wiki.repo_dir
    Dir["*.markdown"].map{ |f| Entry.new :file_name => f.gsub(".markdown", "") }
  end

  def self.find_or_create_file(filename)
    self.new :file_name => filename
  end

  def destroy
    File.delete(@path)
  end

  def updated_at
    @yaml_data[:updated_at]
  end

  def updated_by
    id = @yaml_data[:user]["id"]
    User.exists?(id) ? User.find(id) : User.new
  end

  def save
    if @content
      File.open(@path, 'w'){|f| f.write append_data }
    else
      raise NothingToSaveError
    end
  end

  def persisted?
    false
  end

  private

  def find_or_create_file
    file = File.open @path, File::RDWR|File::CREAT
    content = file.read
    file.close
    content
  end

  def append_data
    @content + YAML.dump(@yaml_data)
  end

  def parse_file
    if @raw_content.match(/---/)
      @raw_content.match(/^(.+)---(.+)/m)
    else
      ["", @raw_content, ""]
    end
  end

end

class NothingToSaveError < StandardError; end
