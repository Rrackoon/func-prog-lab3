defmodule Lab3InterpTest do
  use ExUnit.Case
  test "linear interpolator computes correct values" do
    f = LinearInterpolator.build([{0, 0}, {2, 4}])

    assert_in_delta f.(0), 0.0, 1.0e-12
    assert_in_delta f.(1), 2.0, 1.0e-12
    assert_in_delta f.(2), 4.0, 1.0e-12
    assert_in_delta f.(1.5), 3.0, 1.0e-12
  end

  test "newton interpolator works on a quadratic function" do
    f = NewtonInterpolator.build([{0, 0}, {1, 1}, {2, 4}])

    assert_in_delta f.(0), 0.0, 1.0e-12
    assert_in_delta f.(1), 1.0, 1.0e-12
    assert_in_delta f.(2), 4.0, 1.0e-12
    assert_in_delta f.(1.5), 2.25, 1.0e-12
  end

  test "interpolator chooses linear for 2 points" do
    f = Interpolator.build_interpolator([{1, 2}, {3, 10}])
    assert_in_delta f.(2), 6.0, 1.0e-12
  end

  test "interpolator chooses newton for 3+ points" do
    f = Interpolator.build_interpolator([{0, 0}, {1, 1}, {2, 4}])
    assert_in_delta f.(1.5), 2.25, 1.0e-12
  end

  test "linear interpolation end-to-end basic pipeline" do
    points = [{0, 0}, {2, 4}]
    f = LinearInterpolator.build(points)

    xs = [0, 1, 2]
    ys = Enum.map(xs, f)

    assert Enum.map(ys, &Float.round(&1, 12)) ==
           Enum.map([0.0, 2.0, 4.0], &Float.round(&1, 12))
  end
end
