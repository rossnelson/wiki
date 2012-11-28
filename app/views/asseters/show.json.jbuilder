json.(@asset, :id, :success, :url, :file_identifier)
json.image true if @asset.mime_type[0] == 'image'
json.file true unless @asset.mime_type[0] == 'image'
