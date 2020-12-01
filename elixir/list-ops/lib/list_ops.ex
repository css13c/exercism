defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l, 0)
  end

  @spec do_count(list, non_neg_integer) :: non_neg_integer
  defp do_count([_ | tail], count) do
    do_count(tail, count + 1)
  end

  defp do_count([], count) do
    count
  end

  @spec reverse(list) :: list
  def reverse(l) do
    result = do_reverse(l, [])
  end

  defp do_reverse([head | tail], result) do
    do_reverse(tail, [head | result])
  end

  defp do_reverse([], result) do
    result
  end

  @spec map(list, (any -> any)) :: list
  def map([head | tail], f) do
    [f.(head) | map(tail, f)]
  end

  def map([], _) do
    []
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([head | tail], f) do
    case f.(head) do
      true -> [head | filter(tail, f)]
      false -> filter(tail, f)
    end
  end

  def filter([], _) do
    []
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  def reduce([], acc, _) do
    acc
  end

  @spec append(list, list) :: list
  def append([a_head | a_tail], b) do
    [a_head | append(a_tail, b)]
  end

  def append([], [b_head | b_tail]) do
    [b_head | append([], b_tail)]
  end

  def append([], []) do
    []
  end

  @spec concat([[any]]) :: [any]
  def concat(list) do
    flatten(list, [])
  end

  defp flatten([head | tail], acc) when is_list(head) do
    flatten(tail, flatten(head, acc))
  end

  defp flatten([head | tail], acc) do
    flatten(tail, [head | acc])
  end

  defp flatten([], acc) do
    reverse(acc)
  end
end
