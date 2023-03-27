defmodule Echo do
  @moduledoc """
  Programming Scalable Systems 2023, concurrency on Elixir class
  """
  #spawn(fn () -> Echo.echo() end) runs a process that handles this...
  
  def echo() do
    receive do
      {:msg,msg,sender_pid} -> #sender only can send this type of message
	IO.puts("got message: #{inspect msg}")
	send(sender_pid,msg)
	echo()
    end
  end

  #after -> optional timeout (in millis). Waits AT LEAST time specified
         #IMPORTANT -> Starts waiting after looking all mailbox



  #receive -> not always reads first msg, if first doesn't matches pattern
  #pattern is opcional

  def sleep(time) do #not exact time millis of sleep. Depends on OS.
    receive do
    after time -> :ok
    end
  end

  #good practice -> reads msg and discard it just to limit mailbox size  
end
