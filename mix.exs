defmodule Logexch.MixProject do
  use Mix.Project

  def project do
    [
      app: :logexch,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        logexch_release: [
          applications: [
            logexch: :permanent
          ],
          overlays: ["envs/"],
          path: "_build/rel"
        ]
      ]
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
      {:jason, "~> 1.4.5"},
      {:easy_clickhouse, git: "https://github.com/dvolkow/easy_clickhouse.git", branch: "master"}
    ]
  end
end
