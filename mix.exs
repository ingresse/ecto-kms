defmodule Ecto.Kms.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_kms,
      version: "1.0.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [
        tool: ExCoveralls
      ],
      description: description(),
      package: package()
    ]
  end

  defp description do
    """
    Ecto custom type Ecto.Kms to encrypt content in AWS KMS
    """
  end

  defp package do
    [
      files: [
        "lib",
        "priv",
        ".formatter.exs",
        "mix.exs",
        "README*",
        "LICENSE*"
      ],
      maintainers: [
        "Ingresse",
        "Vitor Leal"
      ],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/ingresse/ecto-kms"
      },
      docs: [
        main: "EctoKMS",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.1"},
      {:ex_aws, "~> 2.0"},
      {:ex_aws_kms, "~> 2.0"}
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.20", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10.1", only: :test},
      {:credo, "~> 0.9.3", only: [:dev, :test], runtime: false}
    ]
  end
end
