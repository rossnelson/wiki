class AssetBuilder

  attr_accessor :assets

  def initialize(options={})
    @data   = options
    @assets = process
  end

  def self.find(ids=[])
    ids.map{ |i| Asset.find i }
  end

  def process
    @data.map do |asset|
      asset[1]["_destroy"] ? destroy(asset) : build(asset)
    end
  end

  def build asset
    Asset.exists?(asset[0]) ? Asset.find(asset[0]).update_attributes(asset[1]) : Asset.create(asset[1])
  end

  def destroy asset
    if Asset.exists?(asset[0])
      asset = Asset.destroy(asset[0])
      asset.id
    end
  end

end
