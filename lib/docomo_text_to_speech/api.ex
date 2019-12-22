defmodule DocomoTextToSpeech.Api do
  @moduledoc false

  @base_url "https://api.apigw.smt.docomo.ne.jp/crayon/v1/textToSpeech?APIKEY="

  alias DocomoTextToSpeech.Parser

  def post(
        text,
        speaker_id \\ 1,
        style_id \\ 1,
        speech_rate \\ 1.0,
        power_rate \\ 1.0,
        voice_type \\ 1.0,
        audio_file_format \\ 2
      ) do
    json_data =
      %{
        Command: "AP_Synth",
        SpeakerID: speaker_id,
        StyleID: style_id,
        TextData: text,
        SpeechRate: speech_rate,
        PowerRate: power_rate,
        VoiceType: voice_type,
        AudioFileFormat: audio_file_format
      }
      |> Poison.encode!()

    "#{@base_url}#{api_key()}"
    |> HTTPoison.post(json_data, headers())
    |> Parser.parse()
  end

  defp api_key, do: Application.get_env(:docomo_text_to_speech, :api_key)

  defp headers, do: [{"Content-Type", "application/json"}]
end
