class PhplistUsersController < ApplicationController
  before_filter :load_phplist_users, :only => [:index]
  before_filter :load_phplist_user, :only => [:show]
  before_filter :load_new_phplist_user, :only => [:new, :create]

  protected
  def load_phplist_users
    if params[:email]
      # if they sent an email, look by email
      @phplist_users = PhplistUser.by_email(params[:email])
    else
      @phplist_users = PhplistUser.find(:all)
    end
  end

  def load_phplist_user
    @phplist_user = PhplistUser.find(params[:id])
  end

  def load_new_phplist_user
    @phplist_user = PhplistUser.new(params[:phplist_user])
  end

  public
  def index
    respond_to do |format|
      format.xml{ render :xml => @phplist_users }
    end
  end

  def show
    respond_to do |format|
      format.xml{ render :xml => @phplist_user }
    end
  end

  def create
    if @phplist_user.save
      respond_to do |format|
        format.xml { render :xml => @phplist_user, :status => :created, :location => @phplist_user }
      end
    else
      respond_to do |format|
        format.xml { render :xml => @phplist_user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
