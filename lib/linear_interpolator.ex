defmodule LinearInterpolator do
  def build([{x0, y0}, {x1, y1}]) when x1 != x0 do
    k = (y1 - y0) / (x1 - x0)
    b = y0 - k * x0
    fn x -> k * x + b end
  end
end
