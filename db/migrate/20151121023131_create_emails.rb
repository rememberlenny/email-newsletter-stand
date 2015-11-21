class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :newsletter_id
      t.string :to
      t.string :from
      t.text :subject
      t.text :body
      t.text :raw_text
      t.text :raw_html
      t.text :raw_body
      t.text :headers
      t.text :raw_headers

      t.timestamps
    end
  end
end
