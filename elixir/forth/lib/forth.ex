defmodule Forth do
  defmodule Evaluator do
    defstruct [:stack, :ops]
    @type t :: %__MODULE__{stack: list(String.t()), ops: Map}
    @type t(ops) :: %__MODULE__{stack: [], ops: ops}

    @doc """
    Adds an operation to the evaluator.
    """
    @spec add_op(Evaluator.t(), String.t(), Function) :: Evaluator.t()
    def add_op(eval, op_name, op_value) do
      %Evaluator{
        eval
        | ops: Map.update(eval.ops, op_name, op_value, fn _ -> op_value end)
      }
    end

    @doc """
    Executes the given term on the evaluator. This can be either a integer,
    which gets pushed onto the stack, or a valid function word (Function words are case-insensitive).

    The initial functions available are:
      * `+`, `-`, `*`, `/` - Performs the given integer arithmatic using the final two values on the stack.
        * ex. `1 2 +` = 3
        * ex. `3 1 -` = 2
      * `DUP` - Duplicates the last value on the stack.
        * ex. `1 DUP` = `1 1`
      * `DROP` - Removes the last value on the stack.
        * ex. `2 1 DROP` = `2`
      * `SWAP` - Swaps the last two values on the stack.
        * ex. `1 2 3 SWAP` = `1 3 2`
      * `OVER` - Duplicates the second-to-last value on the stack.
        * ex. `1 2 3 OVER` = `1 2 3 2`
      * You can also define a new word using the following syntax: `: word-name word-definition ;`
        * ex. `; LEAP_FROG OVER OVER ;` | `1 2 3 LEAP_FROG` = `1 2 3 2 3`
    """
    @spec execute(Evaluator.t(), String.t()) :: Evaluator.t()
    def execute(eval, term) do
      if is_val(term) do
        %Evaluator{eval | stack: eval.stack ++ term}
      else
        eval.ops[term].(eval)
      end
    end

    @spec is_val(any) :: boolean
    defp is_val(term) do
      try do
        Integer.parse(term)
        true
      rescue
        _ -> false
      end
    end

    @spec dup(Evaluator.t()) :: Evaluator.t()
    defp dup(eval) do
      last = List.last(eval.stack)
      %Evaluator{eval | stack: eval.stack ++ last}
    end

    @spec drop(Evaluator.t()) :: Evaluator.t()
    defp drop(eval) do
      %Evaluator{eval | stack: Enum.take(eval.result, length(eval.stack) - 1)}
    end

    defp swap() do
    end

    defp over() do
    end
  end

  @opaque evaluator() :: Evaluator.t()

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    %Forth{
      ops: %{
        "dup" => &dup(&1),
        "drop" => &drop(&1),
        "swap" => fn x -> x end,
        "over" => fn x -> x end,
        "+" => fn x -> x end,
        "-" => fn x -> x end,
        "*" => fn x -> x end,
        "/" => fn x -> x end
      }
    }
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, s) do
  end

  @spec eval_p(evaluator, list(String.t())) :: evaluator
  defp eval_p(ev, []), do: ev

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(ev) do
  end

  @spec is_op(String.t()) :: boolean
  def is_op(s), do: Enum.any?(@ops, &StringHelper.ignore_case_compare(s, &1))

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
