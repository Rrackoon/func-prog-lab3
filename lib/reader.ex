defmodule Reader do
  def start(orchestrator_pid, path \\ nil) do
    spawn(fn -> loop(orchestrator_pid, path) end)
  end

  defp loop(orchestrator_pid, path) do
    input =
      if path && File.exists?(path) do
        File.stream!(path)
      else
        IO.stream(:stdio, :line)
      end

    Enum.each(input, fn line ->
      line = String.trim(line)

      unless line == "" do
        {x, y} = parse_line(line)
        send(orchestrator_pid, {:point, {x, y}})
      end
    end)

    send(orchestrator_pid, :eof)
  end

  defp parse_line(line) do
    [x, y] =
      line
      |> String.split(~r/[;\s\t]+/, trim: true)
      |> Enum.map(&String.to_float/1)

    {x, y}
  end
end
