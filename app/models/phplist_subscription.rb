class PhplistSubscription < ActiveRecord::Base
  establish_connection :phplistdb
  set_table_name "phplist_listuser"

  belongs_to :phplist, :foreign_key => "listid"
  belongs_to :phplist_user, :foreign_key => "userid"
end
