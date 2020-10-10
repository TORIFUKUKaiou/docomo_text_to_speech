defmodule DocomoTextToSpeechTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  @text "I Was Born To Love Elixir"

  describe "run/2" do
    setup [:invalid_api_key, :remove_api_key]

    test "invalid api key" do
      use_cassette "invalid_api_key" do
        expect = {:error, "(401) POLSLA009: Unable to perform ApiKey based Authentication"}
        assert DocomoTextToSpeech.run(@text) == expect
      end
    end
  end

  describe "run!/2" do
    setup [:invalid_api_key, :remove_api_key]

    test "raise exception invalid api key" do
      use_cassette "invalid_api_key" do
        assert_raise RuntimeError, fn ->
          DocomoTextToSpeech.run!(@text)
        end
      end
    end
  end

  defp remove_api_key(_context) do
    ExVCR.Config.filter_sensitive_data("(?<=APIKEY=)([^&]*)", "<REDACTED>")
    :ok
  end

  defp invalid_api_key(_context) do
    System.put_env("DOCOMO_TEXT_TO_SPEECH_API_KEY", "<secret>")
    :ok
  end
end
