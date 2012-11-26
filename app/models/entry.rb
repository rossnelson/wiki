class Entry
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :file_name, :content, :yaml_data, :images, :files, :assets

  def initialize(options={})

    if options[:file_name]
      @file_name = options[:file_name]
      @path = File.join Wiki.repo_dir, "#{options[:file_name]}.markdown"
      @raw_content = find_or_create_file

      @content = parse_file[1]
      @yaml_data = YAML.load parse_file[2]
    end

    @content   = options[:content] if options[:content] 
    #@yaml_data = options[:yaml_data] if options[:yaml_data]
    @assets    = deserialize_assets || []

  end

  def self.find_or_create_file(filename)
    self.new :file_name => filename
  end

  def self.all
    Dir.chdir Wiki.repo_dir
    Dir["*.markdown"].map{ |f| Entry.new :file_name => f.gsub(".markdown", "") }
  end

  def updated_by
    User.find @yaml_data[:user]["id"]
  end

  def updated_at
    @yaml_data[:updated_at]
  end

  def find_or_create_file
    file = File.open @path, File::RDWR|File::CREAT
    content = file.read
    file.close
    content
  end

  def parse_file
    if @raw_content.match(/---/)
      @raw_content.match(/^(.+)---(.+)/m)
    else
      ["", @raw_content, ""]
    end
  end

  def concatenate_content
    @content + YAML.dump(@yaml_data)
  end

  def save
    if @content
      File.open(@path, 'w'){|f| f.write concatenate_content}
    else
      raise NothingToSaveError
    end
  end

  def destroy
    File.delete(@path)
  end

  def persisted?
    false
  end

  def deserialize_assets
    if @yaml_data
      @yaml_data[:assets] ? AssetBuilder.find(@yaml_data[:assets]) : false
    end
  end

end

class NothingToSaveError < StandardError; end
