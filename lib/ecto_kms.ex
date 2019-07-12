defmodule Ecto.Kms do
  @behaviour Ecto.Type

  def type, do: :binary

  def cast(value) do
    {:ok, to_string(value)}
  end

  def dump(value) do
    {:ok, Base.encode64(value, padding: false)}
  end

  def load(value) do
    {:ok, Base.decode64(value, padding: false)}
  end
end
