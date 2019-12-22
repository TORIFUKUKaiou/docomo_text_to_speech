defmodule DocomoTextToSpeech.Parser do
  @moduledoc false

  @doc """
  Parses the response from Livedoor Weather Web Service API calls
  ## Examples
      iex> DocomoTextToSpeech.Parser.parse({:ok, %HTTPoison.Response{body: "elixir", headers: [{"Server", "nginx"}], status_code: 200}})
      {:ok, "elixir", %{"Server" => "nginx"}}

      iex> DocomoTextToSpeech.Parser.parse({:ok, %HTTPoison.Response{body: "elixir", headers: [{"Server", "nginx"}], status_code: 404}})
      {:error, "elixir", %{"Server" => "nginx"}, 404}

      iex> DocomoTextToSpeech.Parser.parse({:error, :hoge})
      {:error, :hoge}

      iex> DocomoTextToSpeech.Parser.parse(:fuga)
      :fuga
  """
  def parse({:ok, %HTTPoison.Response{body: body, headers: headers, status_code: 200}}),
    do: {:ok, body, parse_headers(headers)}

  def parse({:ok, %HTTPoison.Response{body: body, headers: headers, status_code: status_code}}),
    do: {:error, body, parse_headers(headers), status_code}

  def parse(response), do: response

  defp parse_headers(headers), do: Map.new(headers)
end
