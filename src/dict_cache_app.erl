%% @private
-module(dict_cache_app).
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.

start(_Type, _Args) ->
	dict_cache:start_link().

stop(_State) ->
	ok.
