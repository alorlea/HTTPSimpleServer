%% Author: Alberto Lorente Leal, 
%% albll@kth.se
%% a.lorenteleal@gmail.com
%% Created: 04/09/2011
%% Description: Module to parse http requests for our basic server
-module(http).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([parse_request/1, ok/1,get/1]).

%%
%% API Functions
%%



%%
%% Local Functions
%%

parse_request(RO) ->
	{Request, R1} =request_line(RO),
	{Headers, R2} = headers(R1),
	{Body, _} = message_body(R2),
	{Request, Headers, Body}.

request_line([$G, $E, $T, 32 | RO]) ->
	{URI, R1} = request_uri(RO),
	{Ver, R2} =http_version(R1),
	[13,10|R3] =R2,
	{{get,URI,Ver}, R3}.

request_uri([32|RO]) ->
	{[],RO};

request_uri([C|RO]) ->
	{Rest, R1} = request_uri(RO),
	{[C|Rest], R1}.

http_version([$H, $T, $T, $P, $/, $1, $., $1 | R0]) ->
	{v11, R0};

http_version([$H, $T, $T, $P, $/, $1, $., $0 | R0]) ->
	{v10, R0}.

headers([13,10|R0]) ->
	{[],R0};

headers(R0) ->
	{Header, R1} = header(R0),
	{Rest, R2} = headers(R1),
	{[Header|Rest], R2}.

header([13,10|R0]) ->
	{[], R0};

header([C|R0]) ->
	{Rest, R1} = header(R0),
	{[C|Rest], R1}.

message_body(R) ->
	{R, []}.

ok(Body)->
	"HTTP/1.1 200 OK\r\n" ++ "\r\n" ++ Body.

get(URI)->
	"GET" ++ URI ++ " HTTP/1.1\r\n" ++ "\r\n".


