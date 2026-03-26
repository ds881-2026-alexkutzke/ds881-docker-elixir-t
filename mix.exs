defmodule CalculadoraApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :calculadora_api,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CalculadoraApi.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.6"},
      {:jason, "~> 1.4"}
    ]
  end

  defp releases do
    [
      calculadora_api: [
        # Remove informações de debug dos bytecodes BEAM
        # Reduz o tamanho da release em ~5-10 MB
        strip_beams: true
      ]
    ]
  end
end