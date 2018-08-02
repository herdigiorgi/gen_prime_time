-module(gen_check_print).

-behaviour(gen_server).

-export([print/1, start_link/0]).
-export([init/1, handle_call/3, handle_cast/2]).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init(_) ->
  {ok, #{}}.

print(N) ->
  gen_server:call(?MODULE, {print, N}).

handle_call({print, N}, _Caller, State) ->
  io:format("~p~n", [N]),
  {reply, ok, State}.

handle_cast(_, State) -> {noreply, State}.

