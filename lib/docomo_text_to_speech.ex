defmodule DocomoTextToSpeech do
  @moduledoc """
  DocomoTextToSpeech is an Elixir SDK to talk with docomo Developer support textToSpeech API.

  For more details on API, refer to https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_7#tag01

  ## Usage
      DocomoTextToSpeech.run!("エリクサー") |> (&File.write("output.wav", &1)).()
  """

  @doc """
  Converts text to speech

  ## Examples

      iex> DocomoTextToSpeech.run "エリクサー"
      {:ok,
       <<82, 73, 70, 70, 28, 199, 0, 0, 87, 65, 86, 69, 102, 109, 116, 32, 18, 0, 0,
       0, 1, 0, 1, 0, 34, 86, 0, 0, 68, 172, 0, 0, 2, 0, 16, 0, 0, 0, 100, 97, 116,
       97, 246, 198, 0, 0, 0, 0, ...>>}
  """
  def run(
        text,
        speaker_id \\ 1,
        style_id \\ 1,
        speech_rate \\ 1.0,
        power_rate \\ 1.0,
        voice_type \\ 1.0,
        audio_file_format \\ 2
      ) do
    DocomoTextToSpeech.Api.post(
      text,
      speaker_id,
      style_id,
      speech_rate,
      power_rate,
      voice_type,
      audio_file_format
    )
    |> _format_current()
  end

  @doc """
  Converts text to speech

  ## Examples

      iex> DocomoTextToSpeech.run "エリクサー"
      <<82, 73, 70, 70, 28, 199, 0, 0, 87, 65, 86, 69, 102, 109, 116, 32, 18, 0, 0,
        0, 1, 0, 1, 0, 34, 86, 0, 0, 68, 172, 0, 0, 2, 0, 16, 0, 0, 0, 100, 97, 116,
        97, 246, 198, 0, 0, 0, 0, ...>>}
  """
  def run!(
        text,
        speaker_id \\ 1,
        style_id \\ 1,
        speech_rate \\ 1.0,
        power_rate \\ 1.0,
        voice_type \\ 1.0,
        audio_file_format \\ 2
      ) do
    {:ok, content} =
      run(text, speaker_id, style_id, speech_rate, power_rate, voice_type, audio_file_format)

    content
  end

  defp _format_current({:ok, body, _}), do: {:ok, body}
  defp _format_current(error), do: error
end
