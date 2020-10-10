defmodule DocomoTextToSpeech do
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  use Tesla, only: [:post], docs: false

  adapter Tesla.Adapter.Hackney
  plug Tesla.Middleware.BaseUrl, "https://api.apigw.smt.docomo.ne.jp/futureVoiceCrayon/v1"
  plug Tesla.Middleware.Query, APIKEY: api_key()
  plug Tesla.Middleware.JSON

  @default_opts [
    command: "AP_Synth",
    speaker_id: 1,
    style_id: 1,
    speech_rate: 1.0,
    power_rate: 1.0,
    voice_type: 1.0,
    audio_file_format: 2
  ]

  @typedoc "Text to speech conversion option"
  @type conversion_option ::
          {:command, String.t()}
          | {:speaker_id, pos_integer()}
          | {:style_id, pos_integer()}
          | {:speech_rate, float()}
          | {:power_rate, float()}
          | {:voice_type, float()}
          | {:audio_file_format, pos_integer()}

  @doc """
  Converts text to speech.

  ## Examples

  With valid API key.

      iex> DocomoTextToSpeech.run "エリクサー"
      {:ok,
       <<82, 73, 70, 70, 28, 199, 0, 0, 87, 65, 86, 69, 102, 109, 116, 32, 18, 0, 0,
       0, 1, 0, 1, 0, 34, 86, 0, 0, 68, 172, 0, 0, 2, 0, 16, 0, 0, 0, 100, 97, 116,
       97, 246, 198, 0, 0, 0, 0, ...>>}

  Without valid API key.

      iex> DocomoTextToSpeech.run "エリクサー"
      {:error, "(401) POLSLA009: Unable to perform ApiKey based Authentication"}

  Without `APIKEY` URL param.

      iex> DocomoTextToSpeech.run "エリクサー"
      {:error, "(401) POLSLA009: APIKEY is null or empty in the request"}

      iex(5)> DocomoTextToSpeech.run! "エリクサー"
      ** (RuntimeError) (401) POLSLA009: Unable to perform ApiKey based Authentication
          (docomo_text_to_speech) lib/docomo_text_to_speech.ex:97: DocomoTextToSpeech.run!/2

  """
  @spec run(String.t(), [conversion_option()]) :: {:ok | :error, any()}
  def run(text, opts \\ []) do
    params =
      @default_opts
      |> Keyword.merge(opts)
      |> Keyword.put_new(:text_data, text)
      |> Enum.into(%{}, fn {k, v} ->
        {k |> to_string() |> camelize(), v}
      end)

    "/textToSpeech"
    |> post(params)
    |> handle_response()
  end

  @doc """
  Returns the audio file directly or raise exception if any errors.

  ## Examples

  Successfull convertion.

      iex> DocomoTextToSpeech.run! "エリクサー"
      <<82, 73, 70, 70, 28, 199, 0, 0, 87, 65, 86, 69, 102, 109, 116, 32, 18, 0, 0,
        0, 1, 0, 1, 0, 34, 86, 0, 0, 68, 172, 0, 0, 2, 0, 16, 0, 0, 0, 100, 97, 116,
        97, 246, 198, 0, 0, 0, 0, ...>>

  Failed conversion.

      iex(4)> DocomoTextToSpeech.run! "エリクサー"
      ** (RuntimeError) (401) POLSLA009: APIKEY is null or empty in the request
          (docomo_text_to_speech) lib/docomo_text_to_speech.ex:96: DocomoTextToSpeech.run!/2


  """
  @spec run!(String.t(), [conversion_option()]) :: {:ok | :error, any()} | no_return()
  def run!(text, opts \\ []) do
    case run(text, opts) do
      {:ok, content} -> content
      {:error, msg} -> raise msg
    end
  end

  defp api_key do
    System.get_env("DOCOMO_TEXT_TO_SPEECH_API_KEY") ||
      Application.get_env(:docomo_text_to_speech, :api_key)
  end

  defp camelize("speaker_id"), do: "SpeakerID"
  defp camelize("style_id"), do: "StyleID"
  defp camelize(key), do: Macro.camelize(key)

  defp handle_response({:error, _} = error), do: error
  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}

  defp handle_response({:ok, %Tesla.Env{status: status, body: body}}) do
    %{"requestError" => %{"policyException" => %{"messageId" => msg_id, "text" => msg}}} = body
    {:error, "(#{status}) #{msg_id}: #{msg}"}
  end
end
