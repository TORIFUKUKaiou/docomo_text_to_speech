defmodule DocomoTextToSpeech.MixProject do
  use Mix.Project

  @name "DocomoTextToSpeech"
  @source_url "https://github.com/TORIFUKUKaiou/docomo_text_to_speech"

  def project do
    [
      app: :docomo_text_to_speech,
      name: @name,
      version: "0.3.0",
      elixir: "~> 1.8",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      preferred_cli_env: preferred_cli_env()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:hackney, "~> 1.16"},
      {:jason, "~> 1.2"},
      {:tesla, "~> 1.3.0"},
      {:ex_doc, "~> 0.21.2", only: :dev, runtime: false},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:exvcr, "~> 0.12", only: :test}
    ]
  end

  defp description do
    "Elixir client for NTT Docomo TextToSpeech API"
  end

  defp package do
    [
      maintainers: [
        "TORIFUKUKaiou",
        "KianMeng Ang"
      ],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: @name,
      source_url: @source_url
    ]
  end

  defp preferred_cli_env do
    [
      vcr: :test,
      "vcr.delete": :test,
      "vcr.check": :test,
      "vcr.show": :test
    ]
  end
end
