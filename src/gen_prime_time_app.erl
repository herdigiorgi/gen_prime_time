-module(gen_prime_time_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    gen_prime_time_sup:start_link().

stop(_State) ->
    ok.
