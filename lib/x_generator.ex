defmodule XGenerator do
  def between(x0, x1, step) when step > 0 do
    Stream.unfold(x0, fn current ->
      if current <= x1 + 1.0e-12 do
        {current, current + step}
      else
        nil
      end
    end)
  end
end
