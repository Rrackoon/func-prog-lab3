defmodule Printer do
  def print_stream(enumerable, label) do
    enumerable
    |> Enum.each(fn {x, y} ->
      IO.puts("#{label}: #{format(x)} #{format(y)}")
    end)
  end

  defp format(num), do:
    :erlang.float_to_binary(num, [:compact, decimals: 6])
end
