class AssetersController < ApplicationController

  respond_to :json

  def show
    @asset = Asset.find params[:id]
  end

  def create
    file = AppSpecificStringIO.new(params[:qqfile], request.raw_post)
    @asset = Asset.new :file => file
    if @asset.save
      redirect_to asseter_path(@asset.id)
    end
  end

  def destroy
    @asset = Asset.find params[:id]
    respond_with(@asset.destroy)
  end

end
