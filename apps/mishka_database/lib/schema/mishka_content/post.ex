defmodule MishkaDatabase.Schema.MishkaContent.Blog.Post do
  use Ecto.Schema

  require MishkaTranslator.Gettext
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @all_fields ~w(
    title short_description main_image header_image description
    status priority location unpublish alias_link meta_keywords meta_description
    custom_title robots post_visibility allow_commenting allow_liking allow_printing
    allow_reporting allow_social_sharing allow_bookmarking show_hits show_time
    show_authors show_category show_links show_location category_id
  )a


  alias MishkaDatabase.Schema.MishkaContent.{BlogTag, BlogTagMapper}

  schema "blog_posts" do

    field :title, :string, size: 200, null: false
    field :short_description, :string, size: 350, null: false
    field :main_image, :string, size: 200, null: false
    field :header_image, :string, size: 200, null: true
    field :description, :string, null: false
    field :status, ContentStatusEnum, null: false, default: :active
    field :priority, ContentPriorityEnum, null: false, default: :none
    field :location, :string, size: 200, null: true
    field :unpublish, :utc_datetime, null: true
    field :alias_link, :string, size: 200, null: false
    field :meta_keywords, :string, size: 200, null: true
    field :meta_description, :string, size: 164, null: true
    field :custom_title, :string, size: 200, null: true
    field :robots, ContentRobotsEnum, null: false, default: :IndexFollow
    field :post_visibility, PostVisibility, null: false, default: :show
    field :allow_commenting, :boolean, null: true
    field :allow_liking, :boolean, null: true
    field :allow_printing, :boolean, null: true
    field :allow_reporting, :boolean, null: true
    field :allow_social_sharing, :boolean, null: true
    field :allow_bookmarking, :boolean, null: true
    field :allow_subscription, :boolean, null: true
    field :show_hits, :boolean, null: true
    field :show_time, :boolean, null: true
    field :show_authors, :boolean, null: true
    field :show_category, :boolean, null: true
    field :show_links, :boolean, null: true
    field :show_location, :boolean, null: true

    belongs_to :blog_categories, MishkaDatabase.Schema.MishkaContent.Blog.Category, foreign_key: :category_id, type: :binary_id
    has_many :blog_authors, MishkaDatabase.Schema.MishkaContent.BlogAuthor, foreign_key: :post_id

    has_many :blog_likes, MishkaDatabase.Schema.MishkaContent.BlogLike, foreign_key: :post_id
    has_many :blog_tags_mappers, MishkaDatabase.Schema.MishkaContent.BlogTagMapper, foreign_key: :post_id, on_delete: :delete_all


    many_to_many :blog_tags, BlogTag, join_through: BlogTagMapper

    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(
    title short_description main_image description
    status priority alias_link robots post_visibility category_id
  )a

  @spec changeset(struct(), map()) :: Ecto.Changeset.t()
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields, message: MishkaTranslator.Gettext.dgettext("db_schema_content", "فیلد مذکور نمی تواند خالی باشد"))
    |> validate_length(:title, max: 200, message: MishkaTranslator.Gettext.dgettext("db_schema_content", "حداکثر تعداد کاراکتر های مجاز %{number} می باشد", number: 200))
    |> validate_length(:short_description, max: 350, message: MishkaTranslator.Gettext.dgettext("db_schema_content", "حداکثر تعداد کاراکتر های مجاز %{number} می باشد", number: 350))
    |> validate_length(:main_image, max: 200, message: MishkaTranslator.Gettext.dgettext("db_schema_content", "حداکثر تعداد کاراکتر های مجاز %{number} می باشد", number: 200))
    |> validate_length(:header_image, max: 200, message: MishkaTranslator.Gettext.dgettext("db_schema_content", "حداکثر تعداد کاراکتر های مجاز %{number} می باشد", number: 200))
    |> validate_length(:alias_link, max: 200, message: MishkaTranslator.Gettext.dgettext("db_schema_content", "حداکثر تعداد کاراکتر های مجاز %{number} می باشد", number: 200))
    |> validate_length(:meta_keywords, max: 200, message: MishkaTranslator.Gettext.dgettext("db_schema_content", "حداکثر تعداد کاراکتر های مجاز %{number} می باشد", number: 200))
    |> validate_length(:meta_description, max: 164, message: MishkaTranslator.Gettext.dgettext("db_schema_content", "حداکثر تعداد کاراکتر های مجاز %{number} می باشد", number: 164))
    |> validate_length(:custom_title, max: 200, message: MishkaTranslator.Gettext.dgettext("db_schema_content", "حداکثر تعداد کاراکتر های مجاز %{number} می باشد", number: 200))
    |> MishkaDatabase.validate_binary_id(:category_id)
    |> foreign_key_constraint(:category_id, message: MishkaTranslator.Gettext.dgettext("db_schema_content", "ممکن است فیلد مذکور اشتباه باشد یا برای حذف آن اگر اقدام می کنید برای آن وابستگی وجود داشته باشد"))
    |> unique_constraint(:alias_link, name: :index_blog_posts_on_alias_link, message: MishkaTranslator.Gettext.dgettext("db_schema_content", "این لینک قبلا در مطلب دیگری استفاده شده است. لطفا لینک دیگری را انتخاب و ارسال کنید."))
  end

end
