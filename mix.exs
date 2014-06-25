defmodule Spock.Mixfile do
  use Mix.Project

  def project do
    [app: :spock,
     version: "0.0.1",
     elixir: "~> 0.14.2-dev",
     deps: deps]
  end

  def application do
    [applications: []]
  end

  defp deps do
    []
  end
end
