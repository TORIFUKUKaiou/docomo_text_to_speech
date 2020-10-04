defmodule DocomoTextToSpeech.MixProject do
  use Mix.Project

  @name "DocomoTextToSpeech"
  @source_url "https://github.com/TORIFUKUKaiou/docomo_text_to_speech"

  def project do
    [
      app: :docomo_text_to_speech,
      name: @name,
      version: "0.2.0",
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.21.2", only: :dev, runtime: false},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:exvcr, "~> 0.10", only: :test}
    ]
  end

  defp description do
    "Elixir client for NTT Docomo TextToSpeech API"
  end

  defp package do
    [
      maintainers: [
        "TORIFUKUKaiou"
      ],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: @name,
      source_url: @source_url,
    ]
  end
end
