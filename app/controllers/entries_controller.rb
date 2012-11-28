class EntriesController < ApplicationController

  before_filter :require_login

  def index
    @entries = Entry.all
  end

  def show
    @entry = Entry.find_or_create_file params[:id]
    @assets = @entry.assets.map{ |a| a.to_builder.target! }.join(",")
  end

  def new
    @entry = Entry.new
  end

  def edit
    @entry = Entry.find_or_create_file params[:id]
    @assets = @entry.assets.map{ |a| a.to_builder.target! }.join(",")
  end

  def create # and update
    @builder = EntryBuilder.new :entry => params[:entry], :user => current_user
    @entry   = @builder.render

    if @entry.save
      redirect_to entry_path :id => @entry.file_name
    end
  end

  def destroy
    @entry = Entry.find_or_create_file params[:id]
    if @entry.destroy
      redirect_to entries_path
    end
  end

end
