defmodule Main do
  def main(args) do
    {opts, rest, _} =
      OptionParser.parse(args,
        switches: [
          linear: :boolean,
          newton: :boolean,
          step: :float,
          points: :integer
        ],
        aliases: [
          l: :linear,
          n: :newton,
          s: :step,
          p: :points
        ]
      )

    opts = normalize_opts(opts)

    path =
      case rest do
        [path | _] -> path
        _ -> nil
      end

    orchestrator = Orchestrator.start(opts)

    Reader.start(orchestrator, path)

    :ok
  end

  defp normalize_opts(opts) do
    %{
      linear: opts[:linear] || false,
      newton: opts[:newton] || false,
      step: opts[:step] || 0.5,
      points: opts[:points] || 4,
      label: choose_label(opts)
    }
  end

  defp choose_label(opts) do
    cond do
      opts[:linear] and not opts[:newton] -> "linear"
      opts[:newton] and not opts[:linear] -> "newton"
      opts[:linear] and opts[:newton] -> "mixed"
      true -> "interp"
    end
  end
end
