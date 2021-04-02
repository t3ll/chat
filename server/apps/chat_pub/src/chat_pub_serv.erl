-module(chat_pub_serv).

-behaviour(gen_server).

%% API
-export([start_link/0,
         subscribe/1,
         unsubscribe/1,
         publish/2]).

%% Gen_server behaviour callbacks
-export([init/1, 
         handle_call/3, 
         handle_cast/2, 
         terminate/2, 
         code_change/3,
         handle_info/2]).

%%==========================================================
%% API.
%%==========================================================

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

subscribe(Pid) ->
    gen_server:cast(?MODULE, {subscribe, Pid}).

unsubscribe(Pid) ->
    gen_server:cast(?MODULE, {unsubscribe, Pid}).

publish(From, Message) ->
    gen_server:cast(?MODULE, {publish, From, Message}).

%%==========================================================
%% Gen_server behaviour callbacks.
%%==========================================================

init([]) ->
    {ok, []}.

handle_call(_Payload, _From, State) ->
    {ok, State}.

handle_cast({subscribe, Pid}, State) ->
    {noreply, [Pid | State]};
handle_cast({unsubscribe, Pid}, State) ->
    {noreply, lists:delete(Pid, State)};
handle_cast({publish, From, Message}, State) ->
    lists:foreach(fun (Pid) -> Pid ! {publish, From, Message} end, State),
    {noreply, State}.

handle_info(_Payload, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

