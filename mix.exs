defmodule Logexch.MixProject do
  use Mix.Project

  def project do
    [
      app: :logexch,
      version: "0.1.0",
      elixir: "~> 1.18-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Logexch.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dotenvy, "~> 1.0.1"},
      {:jason, "~> 1.2"},
      {:ch, "~> 0.3.0"}
    ]
  end
end
