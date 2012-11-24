class EntriesController < ApplicationController

  before_filter :require_login

  def index
    @entries = Entry.all
  end

  def show
    @entry = Entry.find_or_create_file params[:id]
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new params[:entry]
    if @entry.save
      redirect_to entry_path :id => @entry.file_name
    end
  end

  def edit
    @entry = Entry.find_or_create_file params[:id]
  end

  def update
    @entry = Entry.find_or_create_file params[:id]
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