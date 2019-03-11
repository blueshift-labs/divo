defmodule Mix.Tasks.Test.Integration do
  @moduledoc """
  Mix.Task that run integration tests
  """
  use Mix.Task
  require Logger

  def run(args) do
    env = :integration

    {_, res} =
      System.cmd("mix", ["test", "--no-start", color() | args],
        into: IO.binstream(:stdio, :line),
        env: [{"MIX_ENV", to_string(env)}]
      )

    if res > 0 do
      System.at_exit(fn _ -> exit({:shutdown, 1}) end)
    end
  end

  defp color() do
    if IO.ANSI.enabled?() do
      "--color"
    else
      "--no-color"
    end
  end
end