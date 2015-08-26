-module(dict_cache2_sup).
-behaviour(supervisor).
-export([start_link/1, init/1]).

start_link(Args) ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, Args).

init(_) ->
    ChildId = dict_cache2_id,
    StartFunc = {dict_cache2, start_link, []},
    Restart = permanent,
    Shutdown = 2000,
    SupervisorType = worker,
    Modules = [dict_cache2],
    ChildSpecs = [{ChildId, StartFunc, Restart,
                   Shutdown, SupervisorType, Modules}],
    RestartStrategy = {one_for_one, 15, 60},
    {ok, {RestartStrategy, ChildSpecs}}.
