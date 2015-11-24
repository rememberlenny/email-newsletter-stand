class AddAdminEmailToEmail < ActiveRecord::Migration
  def change
    add_column :emails, :admin_email, :boolean, default: false
  end
end

