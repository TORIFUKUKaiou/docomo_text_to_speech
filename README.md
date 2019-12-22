# DocomoTextToSpeech

> A docomo Developer support textToSpeech API client for Elixir

## Installation

The package can be installed as:

Add `docomo_text_to_speech` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:docomo_text_to_speech, "~> 0.1.0"}
  ]
end
```

## Usage

You will need to configure the docomo Developer support textToSpeech api key properly.

### configuration

The simplest would be to set darksky api key as below:

```
export DOCOMO_TEXT_TO_SPEECH_API_KEY="secret"
```

Now, in your config.exs (or environment specific configuration), add the config block to configure DocomoTextToSpeech.

```elixir
config :docomo_text_to_speech,
  api_key: System.get_env("DOCOMO_TEXT_TO_SPEECH_API_KEY")
```

### Examples

```elixir
export DOCOMO_TEXT_TO_SPEECH_API_KEY="secret"
DocomoTextToSpeech.run!("エリクサー") |> (&File.write("output.wav", &1)).()
```

## License

DocomoTextToSpeech is licensed under the [MIT License](LICENSE).
