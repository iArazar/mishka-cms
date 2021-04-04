defmodule MishkaDatabase.Repo.Migrations.BlogTagsMappers do
  use Ecto.Migration

  def change do
    create table(:blog_tags_mappers, primary_key: false) do
      add(:id, :uuid, primary_key: true)

      add(:post_id, references(:blog_posts, on_delete: :nothing, type: :uuid))
      add(:tag_id, references(:blog_tags, on_delete: :nothing, type: :uuid))

      timestamps()
    end
  end
end
