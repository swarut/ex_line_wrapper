defmodule ExLineWrapper do

  @oauth_endpoint "https://api.line.me/v2/oauth/accessToken"
  @message_endpoint "https://api.line.me/v2/bot/message/reply"

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

  @doc """
  Reply a message

  ## Examples
      iex > ExLineWrapper.reply("message", "reply_token", "access_token")
      {:ok}
  """
  def reply(message, reply_token, access_token) do
    header = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer dsfdsf#{access_token}"}
    ]
    {:ok, body} = Jason.encode(%{
      replyToken: reply_token,
      messages: [%{
        type: "text",
        text: message
      }]
    })
    case HTTPoison.post @message_endpoint, body, header do
      {:ok, %HTTPoison.Response{status_code: 401}} -> {:error}
      {:ok, %HTTPoison.Response{status_code: 200}} -> {:ok}
      {:error, _err} -> {:error}
    end
  end
end
