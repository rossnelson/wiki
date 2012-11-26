class MetaData

  def initialize(current_user, entry, assets)
    @user = current_user
    @entry = entry
    @assets = assets || []
  end

  def user
    @user.meta_data
  end

  def serialize_assets
    @entry.yaml_data[:assets].delete_if{ |id| @assets.include? id } if @entry.yaml_data
    @assets.select!{ |a| a.respond_to?("id") }
    @assets.map!{ |a| a.id }

    @entry.yaml_data ? @entry.yaml_data[:assets].concat(@assets).sort : @assets
  end

  def render
    {
      :user   => user,
      :assets => serialize_assets,
      :updated_at => Time.now
    }
  end

end
