defmodule ChConverterTest do
  use ExUnit.Case
  doctest ChConverter

  test "test conversion from simple to tranditional characters. s_to_t/1" do
    assert ChConverter.s_to_t("宾") == {:ok, ["賔", "賓"]}
    assert ChConverter.s_to_t("较") == {:ok, ["較"]}
    assert ChConverter.s_to_t("怕") == :not_found
  end

  test "test conversion from simple to tranditional characters. t_to_s/1" do
    assert ChConverter.t_to_s("賓") == {:ok, "宾"}
    assert ChConverter.t_to_s("較") == {:ok, "较"}
    assert ChConverter.t_to_s("饕") == :not_found
  end

  test "test input with empty string should return not_found for both s_to_t and t_to_s" do
    assert ChConverter.s_to_t("") == :not_found
    assert ChConverter.t_to_s("") == :not_found
  end

  test "test input with string of length greater than 1 should return not_found" do
    assert ChConverter.s_to_t("宾客") == :not_found
    assert ChConverter.t_to_s("賓客") == :not_found
  end

  test "test input with non-Chinese character should return not_found" do
    assert ChConverter.s_to_t("a") == :not_found
    assert ChConverter.t_to_s("あ") == :not_found
  end
end
