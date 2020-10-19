# DocomoTextToSpeech

<!-- MDOC !-->

Elixir client for NTT Docomo TextToSpeech API.

## Installation

The package can be installed by adding `docomo_text_to_speech` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:docomo_text_to_speech, "~> 0.2.1"}
  ]
end
```

## Configuration

Get your API key from [docomo Developer support](https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_7#tag01) site.

Set the API key to your system environment variable.

```
export DOCOMO_TEXT_TO_SPEECH_API_KEY="secret"
```

In your `config.exs`, set the `api_key` from the system environment variable.

```elixir
config :docomo_text_to_speech,
  api_key: "secret"
```

## Usage

```elixir
iex> DocomoTextToSpeech.run!("エリクサー") |> (&File.write("output.wav", &1)).()
```

## License

DocomoTextToSpeech is licensed under the [MIT License](LICENSE).
