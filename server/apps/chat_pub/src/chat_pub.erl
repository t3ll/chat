-module(chat_pub).

%% API
-export([subscribe/1, unsubscribe/1, publish/2]).

%%==========================================================
%% API.
%%==========================================================
subscribe(Pid) ->
    chat_pub_serv:subscribe(Pid).

unsubscribe(Pid) ->
    chat_pub_serv:unsubscribe(Pid).

publish(From, Message) ->
    chat_pub_serv:publish(From, Message).



