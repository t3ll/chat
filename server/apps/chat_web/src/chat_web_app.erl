%%%-------------------------------------------------------------------
%% @doc chat_web public API
%% @end
%%%-------------------------------------------------------------------

-module(chat_web_app).

-behaviour(application).

-export([start/2, start_phase/3, stop/1]).

start(_StartType, _StartArgs) ->
    chat_web_sup:start_link().

start_phase(start_cowboy, _StartType, []) ->
    Host = '_',
    Routes = [{"/", cowboy_static, {priv_file, chat_web, "index.html"}},
              {"/[...]", cowboy_static, {priv_dir, chat_web, ""}}],
    Dispatch = cowboy_router:compile([{Host, Routes}]),
    {ok, _} = cowboy:start_clear(chat_web_listener,
        [{port, 8000}],
        #{env => #{dispatch => Dispatch}}
    ),
    ok.

stop(_State) ->
    ok.

%% internal functions
