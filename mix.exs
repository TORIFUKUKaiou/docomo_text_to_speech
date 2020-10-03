defmodule DocomoTextToSpeech.MixProject do
  use Mix.Project

  def project do
    [
      app: :docomo_text_to_speech,
      version: "0.2.0",
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/TORIFUKUKaiou/docomo_text_to_speech"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.21.2", only: :dev, runtime: false},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:exvcr, "~> 0.10", only: :test}
    ]
  end

  defp description() do
    "A docomo Developer support textToSpeech API client for Elixir"
  end

  defp package() do
    [
      maintainers: [
        "TORIFUKUKaiou"
      ],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/TORIFUKUKaiou/docomo_text_to_speech"}
    ]
  end
end
