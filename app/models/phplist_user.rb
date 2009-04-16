class PhplistUser < ActiveRecord::Base
  establish_connection :phplistdb
  set_table_name "phplist_user_user"

  has_many :phplist_subscriptions, :foreign_key => "userid"
  has_many :phplists, :through => :phplist_subscriptions

  named_scope :by_email, lambda{ |email| { :conditions => ["email = ?", email]} }
end
