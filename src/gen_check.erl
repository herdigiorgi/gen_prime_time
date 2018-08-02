-module(gen_check).

-behaviour(gen_server).

-export([start_link/1, is_prime/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).

start_link(Seconds) ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, Seconds, []).

init(Seconds) ->
  call_myself_after(Seconds),
  {ok, Seconds}.

handle_call(_Call, _Caller, State) ->
  {reply, nothing, State}.

handle_cast(_Cast, State) ->
  {noreply, State}.

handle_info({msg, check}, Seconds) ->
  check_seconds(),
  call_myself_after(Seconds),
  {noreply, Seconds};
handle_info(_Info, State) ->
  {noreply, State}.

call_myself_after(Seconds) ->
  timer:send_after(Seconds * 1000, ?MODULE, {msg, check}).

check_seconds() ->
  Current = current_second(),
  case is_prime(Current) of
    true -> gen_check_print:print(Current);
    _ -> ok
  end.

current_second() ->
  {_,{_,_,Seconds}} = calendar:local_time(),
  Seconds.

is_prime(N) -> is_prime(N, N-1).
is_prime(_, D) when D =< 1 -> true;
is_prime(N, D) ->
  case N rem D of
    0 -> false;
    _ -> is_prime(N, D-1)
  end.
