%%%-------------------------------------------------------------------
%% @doc chat_ws public API
%% @end
%%%-------------------------------------------------------------------

-module(chat_ws_app).

-behaviour(application).

-export([start/2, start_phase/3, stop/1]).

start(_StartType, _StartArgs) ->
    chat_ws_sup:start_link().

start_phase(start_cowboy, _StartType, []) ->
    Host = '_',
    Routes = [{"/websocket", chat_ws_h, []}],
    Dispatch = cowboy_router:compile([{Host, Routes}]),
	{ok, _} = cowboy:start_clear(http, [{port, 9000}], #{
		env => #{dispatch => Dispatch}
	}),
    ok.

stop(_State) ->
    ok.

%% internal functions
