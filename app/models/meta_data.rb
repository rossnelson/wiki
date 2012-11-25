class MetaData

  def initialize(current_user, assets={})
    @user = current_user
    #@entry = entry
    @assets = assets
  end

  def user
    @user.meta_data
  end

  def serialize_assets
    {
      "files"  => [{:id => 1, :filename => "wibble.jpg"}, {:id => 1, :filename => "wibble.jpg"}],
      "assets" => [{:id => 1, :filename => "wibble.jpg"}, {:id => 1, :filename => "wibble.jpg"}]
    }
  end

  def render
    {
      #:meta   => @entry.yaml,
      :user   => user,
      :assets => serialize_assets,
      :updated_at => Time.now
    }
  end

end
