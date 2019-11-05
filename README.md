# ChConverter
A chinese characters' simple <-> tradition conversion implementation
by macro.

The conversion is defined in the file priv/conversion.txt.

APIs:
    1. Convert a simple Chinese character to a traditional Chinese characters.
    Some simple character may have more than one trandition counterparts.

```elixir
ChConverter.s_to_t("宾") == {:ok, ["賔", "賓"]}
ChConverter.s_to_t("较") == {:ok, ["較"]}
ChConverter.s_to_t("怕") == :not_found
```

    2. Convert a traditional Chinese to a simple character

```elixir
ChConverter.t_to_s("賓") == {:ok, "宾"}
ChConverter.t_to_s("較") == {:ok, "较"}
ChConverter.t_to_s("饕") == :not_found
```

## Installation [not available]

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ch_converter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ch_converter, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ch_converter](https://hexdocs.pm/ch_converter).
