defmodule PointSelector do
  def ready?(window, opts) do
    size = Window.size(window)

    cond do
      opts.linear and not opts.newton ->
        Window.enough?(window, 2)

      opts.newton and not opts.linear ->
        Window.enough?(window, size)

      opts.linear and opts.newton ->
        case Window.to_list(window) |> length() do
          2 -> true
          l when l >= size -> true
          _ -> false
        end

      true -> false
    end
  end
end
