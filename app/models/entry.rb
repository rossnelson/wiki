class Entry
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :file_name, :content, :yaml, :images, :files

  def initialize(options={})

    if options[:file_name]
      @file_name = options[:file_name]
      @path = File.join Wiki.repo_dir, "#{options[:file_name]}.markdown"
      @raw_content = find_or_create_file

      @content = parse_file[1]
      @yaml = YAML.load parse_file[2]
    end

    @content = options[:content] if options[:content] 
    @yaml    = options[:yaml] if options[:yaml]

  end

  def self.find_or_create_file(filename)
    self.new :file_name => filename
  end

  def self.all
    Dir.chdir Wiki.repo_dir
    Dir["*.markdown"].map{ |f| Entry.new :file_name => f.gsub(".markdown", "") }
  end

  def find_or_create_file
    file = File.open @path, File::RDWR|File::CREAT
    file.read
  end

  def parse_file
    if @raw_content.match(/---/)
      @raw_content.match(/^(.+)---(.+)/m)
    else
      ["", @raw_content, ""]
    end
  end

  def concatenate_content
    @content + "\n\n" + YAML.dump(@yaml)
  end

  def save
    if @content
      File.open(@path, 'w'){|f| f.write concatenate_content}
    else
      raise NothingToSaveError
    end
  end

  def persisted?
    false
  end

  # For Later
  #
  #def serialize_assets
    #assets={}
    #assets[:images] = images.map{|i| i.id}
    #assets[:files]  = files.map{|f| f.id}
    #assets.to_yaml
  #end

  #def deserialize_images
    
  #end

end

class NothingToSaveError < StandardError; end
