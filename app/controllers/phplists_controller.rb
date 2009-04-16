class PhplistsController < ApplicationController
  before_filter :load_phplists, :only => [:index]

  protected
  def load_phplists
    @phplists = Phplist.find(:all)
  end

  public
  def index
    respond_to do |format|
      format.xml{ render :xml => @phplists }
    end
  end
end
