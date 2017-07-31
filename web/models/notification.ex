defmodule Social.Notification do
  use Social.Web, :model
  
  @required_params [:message, :user_id]

  schema "notifications" do
    field :message, :string, null: false
    belongs_to :user, Social.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> foreign_key_constraint(:user_id)
  end
end
