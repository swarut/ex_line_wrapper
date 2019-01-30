defmodule ExLineWrapper do

  @oauth_endpoint "https://api.line.me/v2/oauth/accessToken"

  @moduledoc """
  Documentation for ExLineWrapper.
  """


  @doc """
  Acquire access token

  ## Examples
    iex> ExLineWrapper.authenticate("channel_id", "channel_secret")
    {:ok, %{"access_token" => "xxxxxx"}}
  """
  def authenticate(channel_id, channel_secret) do
    header = [
      {"Content-Type", "application/x-www-form-urlencoded"}
    ]
    body = URI.encode_query(%{
      grant_type: "client_credentials",
      client_id: channel_id,
      client_secret: channel_secret
    })
    IO.puts("body = #{inspect body}")
    case HTTPoison.post @oauth_endpoint, body, header do
      {:ok, resp = %HTTPoison.Response{status_code: 400, body: body}} ->
        IO.puts("STATUS 400: Unauthorized --- #{inspect resp}")
        {:ok, body} = Jason.decode(body)
        {:error, body}
      {:ok, resp = %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts("SENNNTTTT #{inspect resp}")
        Jason.decode(body)
      {:error, err} ->
        {:error, err}
    end
  end
end
