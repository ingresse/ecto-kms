defmodule Ecto.Kms do
  @moduledoc """
  Custom AWS KMS encrypt field type
  When dump to the database data must be encrypted
  When load from the database data must be decrypted
  """
  alias ExAws.KMS

  @key_id Application.get_env(:ecto_kms, :encrypt_key)[:id]
  @behaviour Ecto.Type

  @doc false
  def type, do: :binary

  @doc false
  def cast(data), do: {:ok, to_string(data)}

  @doc """
  Pipe down the incoming string to the AWS KMS service
  and returns the encrypted string in case of success.
  """
  def dump(data) when is_binary(data) do
    with {:ok, encrypted} <- encrypt(data) do
      {:ok, encrypted["CiphertextBlob"]}

    else
      {:error, _} -> {:error, :credit_card_encryption_failed}
    end
  end
  def dump(_), do: :error

  @doc """
  Pipe down the data hashed string from database to the
  AWS KMS service to be decrypted.
  """
  def load(data) when is_binary(data) do
    with {:ok, decrypted} <- decrypt(data) do
      {:ok, decrypted}

    else
      {:error, _} -> {:error, :credit_card_decryption_failed}
    end
  end

  defp encrypt(data) do
    data
    |> Base.encode64()
    |> (&KMS.encrypt(&2, &1)).(@key_id)
    |> ExAws.request()
  end

  defp decrypt(data) do
    data
    |> KMS.decrypt()
    |> ExAws.request()
    |> decode()
  end

  defp decode({:error, _}), do: {:error, %{}}
  defp decode({:ok, body}), do: Base.decode64(body["Plaintext"])
end
