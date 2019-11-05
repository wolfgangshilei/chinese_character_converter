defmodule ChConverter do
  @moduledoc """
  A chinese characters' simple <-> tradition conversion implementation
  by macro.

  The conversion is defined in the file priv/conversion.txt.

  APIs:
  1. Convert a simple Chinese character to a traditional Chinese characters.
  Some simple character may have more than one trandition counterparts.

  s_to_t(string()) -> {:ok, list(string())} | :not_found

  2. Convert a traditional Chinese to a simple character

  t_to_s(string()) -> {:ok, string()} | :not_found
  """

  @external_resource conversion_path = Path.join(__DIR__, "../priv/conversion.txt")

  {:ok, agent} = Agent.start_link(fn -> %{} end)
  for line <- File.stream!(conversion_path, [], :line) do
    pairs = line |> String.trim |> String.trim_trailing(";") |> String.split(";")

    for pair <- pairs do
      [simple, tradition] = String.split(pair, "=")

      Agent.update(agent, fn state ->
        Map.update(state, simple, [tradition], &([tradition | &1]))
      end)
    end
  end

  l =
    Agent.get(agent, fn state -> state end)

    |> Map.to_list

  for {simple, traditions} <- l do
    def s_to_t(unquote(simple)), do: {:ok, unquote(traditions)}
    def t_to_s(tradition) when tradition in unquote(traditions), do: {:ok, unquote(simple)}
  end

  Agent.stop(agent)
  def s_to_t(_s), do: :not_found
  def t_to_s(_t), do: :not_found
end
