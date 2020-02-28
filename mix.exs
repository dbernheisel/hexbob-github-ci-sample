defmodule AlpineTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :alpine_test,
      version: "0.1.0",
      elixir: "~> 1.4",
      aliases: aliases(),
      start_permanent: Mix.env() == :prod,
      dialyzer: plt_file(),
      deps: deps(),
      preferred_cli_env: [
        typespecs: :test,
        dialyzer: :test,
        tests: :test
      ]
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
    []
    |> add_if({:credo, "~> 1.1", only: [:dev, :test], runtime: false}, ">= 1.5.0")
    |> add_if({:dialyxir, "~> 1.0.0-rc.7", only: [:dev, :test], runtime: false}, ">= 1.6.0")
  end

  defp aliases do
    [
      tests: tests(),
      typespecs: typespecs()
    ]
  end

  defp tests do
    []
    |> add_if("compile --force --warnings-as-errors", !System.get_env("CI"))
    |> add_if("format --check-formatted", ">= 1.10.0")
    |> add_if("credo --strict", ">= 1.6.0")
    |> add_if("test", true)
    |> typespecs()
  end

  defp typespecs(commands \\ []) do
    commands
    |> add_if("dialyzer", ">= 1.6.0")
  end

  @plt_path Path.join(["priv", "plts"])
  defp plt_file() do
    if System.get_env("CI") == "true" do
      :ok = File.mkdir_p(@plt_path)

      [
        plt_file: {:no_warn, Path.join([@plt_path, "project.plt"])},
        plt_core_path: @plt_path
      ]
    else
      []
    end
  end

  defp add_if(commands, command, true), do: commands ++ [command]
  defp add_if(commands, _command, ""), do: commands

  defp add_if(commands, command, version) when is_binary(version) do
    add_if(commands, command, Version.match?(System.version(), version))
  end

  defp add_if(commands, _command, _), do: commands
end
