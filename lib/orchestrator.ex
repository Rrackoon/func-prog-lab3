defmodule Orchestrator do
  def start(opts) do
    spawn(fn -> loop(Window.new(opts.points), opts) end)
  end

  defp loop(window, opts) do
    receive do
      {:point, point} ->
        window = Window.add(window, point)

        if PointSelector.ready?(window, opts) do
          process_window(window, opts)
        end

        loop(window, opts)

      :eof ->
        process_tail(window, opts)
        :ok
    end
  end

  defp process_window(window, opts) do
    points = Window.to_list(window)
    f = Interpolator.choose(points, opts)

    [{x0, _}, {x1, _} | _] = points

    XGenerator.between(x0, x1, opts.step)
    |> Stream.map(fn x -> {x, f.(x)} end)
    |> Printer.print_stream(opts.label)
  end

  defp process_tail(window, opts) do
    points = Window.to_list(window)
    f = Interpolator.choose(points, opts)

    [{x0, _} | _] = points
    {x_last, _} = List.last(points)

    XGenerator.between(x0, x_last, opts.step)
    |> Stream.map(fn x -> {x, f.(x)} end)
    |> Printer.print_stream(opts.label)
  end
end
