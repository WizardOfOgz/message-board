class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :post, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.text :body, null: false

      t.timestamps null: false
    end

    add_foreign_key :comments, :posts, name: "fk_post_id_on_comments"
    add_foreign_key :comments, :users, name: "fk_user_id_on_comments"

    reversible do |dir|
      dir.up do
        # Place a reasonable, yet arbitrary, limit on user input.
        execute <<~SQL
          ALTER TABLE comments ADD CONSTRAINT body_limit CHECK (length(body) < #{ 100_000 })
        SQL
      end
    end
  end
end
