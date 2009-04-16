class PhplistSubscriptionsController < ApplicationController
  before_filter :load_phplist_subscriptions, :only => [:index]
  before_filter :load_phplist_subscription, :only => [:show]
  before_filter :load_new_phplist_subscription, :only => [:new, :create]
  before_filter :load_phplist_user, :only => [:unsubscribe_user, :subscribe_user]

  protected
  def load_phplist_subscriptions
    if params[:email]
      # if they sent an email, look by email
      @phplist_subscriptions = PhplistSubscription.by_email(params[:email])
    else
      @phplist_subscriptions = PhplistSubscription.find(:all)
    end
  end

  def load_phplist_subscription
    @phplist_subscription = PhplistSubscription.find(params[:id])
  end

  def load_new_phplist_subscription
    @phplist_subscription = PhplistSubscription.new(params[:phplist_subscription])
  end

  def load_phplist_user
    @phplist_user = PhplistUser.find_by_email(params[:email])
  end

  public
  def index
    respond_to do |format|
      format.xml{ render :xml => @phplist_subscriptions }
    end
  end

  def show
    respond_to do |format|
      format.xml{ render :xml => @phplist_subscription }
    end
  end

  def create
    if @phplist_subscription.save
      respond_to do |format|
        format.xml { render :xml => @phplist_subscription, :status => :created, :location => @phplist_subscription }
      end
    else
      respond_to do |format|
        format.xml { render :xml => @phplist_subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  def unsubscribe_user
    if params[:list_id] # just unsubscribe from one
      PhplistSubscription.connection.execute "DELETE FROM phplist_listuser WHERE userid = #{@phplist_user.id} AND listid=#{params[:list_id]}" rescue nil
    else # unsubscribe from all
      PhplistSubscription.connection.execute "DELETE FROM phplist_listuser WHERE userid = #{@phplist_user.id}" rescue nil
    end
    respond_to do |format|
      format.xml { render :xml => [], :status => :ok }
    end
  end

  def subscribe_user
    PhplistSubscription.create(:listid => params[:list_id], :userid => @phplist_user.id, :modified => DateTime.now) rescue nil
    respond_to do |format|
      format.xml { render :xml => [], :status => :ok}
    end
  end
end
