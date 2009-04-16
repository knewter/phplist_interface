class Phplist < ActiveRecord::Base
  establish_connection :phplistdb
  set_table_name "phplist_list"
  validates_presence_of :name

  has_many :phplist_subscriptions, :foreign_key => "listid"
  has_many :phplist_users, :through => :phplist_subscriptions
end
