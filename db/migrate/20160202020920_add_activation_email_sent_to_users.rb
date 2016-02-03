class AddActivationEmailSentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_email_sent, :boolean, :default => false
  end
end
