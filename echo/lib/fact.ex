defmodule Fact do
  defp f(1) do
    1
  end

  defp f(n) when n>1 do
    n*f(n-1)
  end

  def start() do
    #spawn(fn () -> fact() end)
    #spawn(fn () -> Process.register(self(), :factserver), fact() end) -> dangerous. focus WHEN this happend
    Process.register(spawn(fn () -> fact() end), :factserver)
  end

  def compute_fact(n) do
    send(:factserver, {:fact,n,self()}) #-> this is blocking if its very big
    receive do
      x -> x
    end
  end
  
  defp fact() do
    receive do
      {:fact, n, pid} ->
	#send(pid,f(n)) -> blocking
	spawn(fn() -> send(pid,f(n))end)
	fact()
      other ->
	IO.puts("got unexpected msg #{inspect other}")
	fact()
    end
  end
end
