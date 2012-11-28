class EntryBuilder

  attr_accessor :user, :entry

  def initialize(options={})
    @entry  = Entry.new options[:entry]
    @user   = options[:user]

    if options[:entry][:assets]
      @assets = options[:entry][:assets]
    end
  end

  def render
    @yaml_data = MetaData.new(@user, @entry, @assets)
    @entry.yaml_data = @yaml_data.render

    @entry
  end

end
