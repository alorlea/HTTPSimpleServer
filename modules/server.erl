%% Author: Alberto Lorente Leal, 
%% albll@kth.se
%% a.lorenteleal@gmail.com
%% Created: 06/09/2011
%% Description: Server module to start and stop the server
-module(server).

%%
%% Include files
%%
-import(rudy, [init/1]).
%%
%% Exported Functions
%%
-export([start/1, stop/0]).

%%
%% API Functions
%%



%%
%% Local Functions
%%

start(Port)->
	register(rudy, spawn(fun()->init(Port) end)).

stop()->
	exit(whereis(rudy), "time to die").