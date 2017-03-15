defmodule DocsUsers.V1.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias DocsUsers.Repo
  alias DocsUsers.V1.User

  def for_token(user = %User{}), do: { :ok, "UUID:#{user.uuid}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("UUID:" <> uuid), do: { :ok, Repo.get_by(User, uuid: uuid) }
  def from_token(_), do: { :error, "Unknown resource type" }
end