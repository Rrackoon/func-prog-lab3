defmodule Interpolator do
  def choose(points, opts) do
    cond do
      opts.linear and not opts.newton ->
        build_linear(points)

      opts.newton and not opts.linear ->
        build_newton(points)

      opts.linear and opts.newton ->
        case length(points) do
          2 -> build_linear(points)
          _ -> build_newton(points)
        end

      true ->
        raise "Не указан алгоритм интерполяции"
    end
  end

  defp build_linear(points), do: LinearInterpolator.build(points)
  defp build_newton(points), do: NewtonInterpolator.build(points)

  def build_interpolator(points) do
    case length(points) do
      2 -> LinearInterpolator.build(points)
      _ -> NewtonInterpolator.build(points)
    end
  end
end
