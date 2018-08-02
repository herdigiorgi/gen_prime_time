-module(gen_prime_time_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
  Children =
    [
     #{id => gen_check_print,
       start => {gen_check_print, start_link, []}},
     #{id => gen_check,
       start => {gen_check, start_link, [1]}}
    ],
  {ok, { {one_for_all, 0, 1}, Children}}.

