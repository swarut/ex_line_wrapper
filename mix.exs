defmodule ExLineWrapper.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_line_wrapper,
      version: "0.1.3",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "ExLineWrapper",
      source_url: "https://github.com/swarut/ex_line_wrapper",
      description: description(),
      package: package()
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
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:httpoison, "~> 1.4"},
      {:jason, "~> 1.1"}
    ]
  end

  defp description() do
    "Line API wrapper."
  end

  defp package() do

    [
      maintainers: ["Warut Surapat"],
      licenses: ["MIT"],
      links: %{"Github" =>"https://github.com/swarut/ex_line_wrapper"}
    ]
  end
end
