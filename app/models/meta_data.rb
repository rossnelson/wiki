class MetaData

  def initialize(current_user, entry, assets)
    @user = current_user
    @entry = entry
    @assets = assets || []
  end

  def self.deserialize_assets(entry)
    if entry.yaml_data
      entry.yaml_data[:assets] ? AssetBuilder.find(entry.yaml_data[:assets]) : false
    end
  end

  def user
    @user.meta_data
  end

  def render
    {
      :user   => user,
      :assets => @assets,
      :updated_at => Time.now
    }
  end

end
