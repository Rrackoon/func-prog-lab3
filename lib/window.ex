defmodule Window do
  def new(size) when is_integer(size) and size >= 2 do
    %{buf: [], size: size}
  end

  def add(%{buf: buf, size: size} = w, point) do
    new_buf = (buf ++ [point]) |> Enum.take(-size)
    %{w | buf: new_buf}
  end

  def to_list(%{buf: buf}), do: buf

  def enough?(%{buf: buf}, needed_size) do
    length(buf) >= needed_size
  end

  def size(%{size: s}), do: s
end
