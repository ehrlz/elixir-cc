# Concurrency in Elixir

## Basic concepts
Each process runs a function. When the function terminates, the process ends.
Each process owns a _mailbox_, that contains messages received, and can be read.

## Processes
Some function for managing processes:

### `self()` 
  Answers the pid from the process that call the function.

	e.g.
	```terminal
	iex(1)> self
	#PID<0.106.0>
	```

###	`Process.alive?(pid)` 
	Answers if `pid` process is still running.


###	`spawn(fn)` 
	Creates a new process that runs `fn` function. When `fn` is done, the process dies. Returns pid of new process.

	E.g.
	```elixir
	spawn(fn()-> 1+1 end)
	```

## Messages
Function for send messages between processes:

### `send(pid,msg)`
	Sends `msg` to `pid` process. Async, not block, just send and hopes it reach destination.
	Msg can be any format, but for being received, must be accepted by the destination.
	Is a good practice to send the sender pid on `msg`.

	E.g.

	```elixir
	pid = self()

	send(pid, "string") #send itself

	#other type
	send(pid,{:msg,"pepe",sender_pid}
	```

### `receive` 
  Reads the first acceptable message in process _mailbox_.

	E.g.
	```elixir
	receive do
		{:msg, x, sender_pid} -> IO.puts(x)
	end
	```
	This code only accepts a message with a certain format.
	Each message that isn't accepted reamins in _mailbox_.

	Other example:
	```elixir
	receive do
		{:msg, x, sender_pid} -> IO.puts(x)
		other -> IO.puts("got unexpected msg #{inspect other}")
	end
	```
	This code reads every message from _mailbox_ but only accepts the formatted ones.
	Is a good practice to not let the _mailbox_ grow to much.

	
	Can be a timeout(in millis) in receive. Is optional and waits AT LEAST the time specified (can't be exact for OS process manipulation).
	Starts waiting after looking ALL messages in _mailbox_.
	
	```elixir
	receive do
		{:msg, x, sender_pid} -> IO.puts(x)
		after 1000 -> "no match"
	end
	```
