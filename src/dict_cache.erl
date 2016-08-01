-module(dict_cache).
-behaviour(gen_server).
-export([start_link/0, get_value/1, set_value/2]).
-export([init/1, handle_call/3, terminate/2]).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

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

terminate(_Reason, _State) ->
	ok.
