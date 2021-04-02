%%%-------------------------------------------------------------------
%% @doc chat_pub public API
%% @end
%%%-------------------------------------------------------------------

-module(chat_pub_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    chat_pub_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
