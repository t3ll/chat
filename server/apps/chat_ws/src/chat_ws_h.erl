-module(chat_ws_h).

-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2]).

init(Req, Opts) ->
	{cowboy_websocket, Req, Opts}.

websocket_init(State) ->
    chat_pub:subscribe(self()),
	{[], State}.

websocket_handle({text, Msg}, State) ->
    chat_pub:publish(self(), {text, Msg}),
	{[], State};
websocket_handle(_Data, State) ->
	{[], State}.

websocket_info({publish, _From, Payload}, State) ->
	{[Payload], State};
websocket_info(_Info, State) ->
	{[], State}.
