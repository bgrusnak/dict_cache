-module(dict_cache2).
-behaviour(gen_server).
-export([start/0, get_value/1, set_value/2]).
-export([init/1, handle_call/3]).

start() ->
  gen_server:start({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
  {ok, dict:new()}.

handle_call({set_value, Key, Value}, _from, Data) ->
  NewData = dict:store(Key, Value, Data),
  {reply, ok, NewData};
handle_call({get_value, Key}, _From, Data) ->
  Value = dict:fetch(Key, Data),
  {reply, Value, Data}.

set_value(Key, Value) ->
  gen_server:call(?MODULE, {set_value, Key, Value}).

get_value(Key) ->
  gen_server:call(?MODULE, {get_value, Key}).
