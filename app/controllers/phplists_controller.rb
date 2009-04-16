class PhplistsController < ApplicationController
  before_filter :load_phplists, :only => [:index]
  before_filter :load_phplist, :only => [:show]

  protected
  def load_phplists
    @phplists = Phplist.find(:all)
  end

  def load_phplist
    @phplist = Phplist.find(params[:id])
  end

  public
  def index
    respond_to do |format|
      format.xml{ render :xml => @phplists }
    end
  end

  def show
    respond_to do |format|
      format.xml{ render :xml => @phplist }
    end
  end
end
