-module(dict_cache).
-export([start/0, get_value/1, set_value/2]).

start() ->
	Data = dict:new(),
	Pid = spawn(fun() -> server_loop(Data) end),
	erlang:register(dict_cache, Pid).

server_loop(Data) ->
	receive
		{get_value, FromPid, Key} ->
			Value = dict:fetch(Key, Data),
			  FromPid ! {ok, Value},
			  server_loop(Data);
		{set_value, FromPid, Key, Value} ->
			NewData = dict:store(Key, Value, Data),
			FromPid ! ok,
			server_loop(NewData)
	end.

set_value(Key, Value) ->
	dict_cache ! {set_value, self(), Key, Value},
	receive
		ok -> ok
	end.

get_value(Key) ->
	dict_cache ! {get_value, self(), Key},
	receive
		{ok, Value} -> Value
	end.
