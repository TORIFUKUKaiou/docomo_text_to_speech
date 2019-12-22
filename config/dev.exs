use Mix.Config

config :docomo_text_to_speech,
  api_key: System.get_env("DOCOMO_TEXT_TO_SPEECH_API_KEY")
