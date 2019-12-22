defmodule DocomoTextToSpeech.ApiTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  @text "I Was Born To Love Elixir"

  setup_all do
    HTTPoison.start()
  end

  test "post" do
    use_cassette "httpoison_post" do
      {:ok, body, %{"Content-Type" => "audio/wav"}} = DocomoTextToSpeech.Api.post(@text)
      assert body
    end

    use_cassette "httpoison_post_error" do
      {:error, body, %{"Content-Type" => "application/json"}, status_code} =
        DocomoTextToSpeech.Api.post(@text)

      assert body
      assert status_code
    end
  end
end
