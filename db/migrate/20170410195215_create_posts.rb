class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true, null: false
      t.string :title, limit: 127, null: false
      t.text :body, null: false

      t.timestamps null: false
    end

    add_foreign_key :posts, :users, name: "fk_user_id_on_posts"

    reversible do |dir|
      dir.up do
        # Place a reasonable, yet arbitrary, limit on user input.
        execute <<~SQL
          ALTER TABLE posts ADD CONSTRAINT body_limit CHECK (length(body) < #{ 100_000 })
        SQL
      end
    end
  end
end
