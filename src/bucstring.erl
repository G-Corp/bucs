-module(bucstring).

-export([
         sub/3
         , gsub/3
         , split/2
         , lowercase/1
         , uppercase/1
        ]).

%% @doc
%% Return an new string with the first occurance of <tt>Old</tt> substitued by <tt>New</tt>
%%
%% Example:
%% <pre lang="erlang">
%% "HeLlo World" = estring:sub("Hello World", "l", "L").
%% </pre>
%% @end
-spec sub(Str :: string(), Old :: string(), New :: string()) -> string().
sub(Str, Old, New) ->
  FStr = lists:flatten(Str),
  FOld = lists:flatten(Old),
  FNew = lists:flatten(New),
  Lstr = length(FStr),
  Lold = length(FOld),
  Pos  = string:str(FStr, FOld),
  if
    Pos =:= 0 ->
      FStr;
    true      ->
      LeftPart = string:left(FStr, Pos-1),
      RitePart = string:right(FStr, Lstr-Lold-Pos+1),
      string:concat(string:concat(LeftPart, FNew), RitePart)
  end.

%% @doc
%% Return an new string with the all occurances of <tt>Old</tt> substitued by <tt>New</tt>
%%
%% Example:
%% <pre lang="erlang">
%% "HeLLo WorLd" = estring:gsub("Hello World", "l", "L").
%% </pre>
%% @end
-spec gsub(Str :: string(), Old :: string(), New :: string()) -> string().
gsub(Str, Old, New) ->
  %Acc = sub(Str,Old,New),
  %subst(Acc,Old,New,Str).
  gsub(Str, Old, New, "").

gsub("", _Old, _New, Acc) -> lists:flatten(Acc);
gsub(Str, Old, New, Acc) ->
  case string:str(Str, Old) of
    0 ->
      gsub("", Old, New, Acc ++ Str);
    Pos ->
      Pre = string:left(Str, Pos - 1),
      Rest = string:right(Str, length(Str) - Pos + 1 - length(Old)),
      gsub(Rest, Old, New, Acc ++ Pre ++ New)
  end.

%% @doc
%% Split string
%% @end
-spec split(Str :: string(), Token :: string()) -> string().
split(String, Token) ->
  case bucs:function_exists(string, split, 3) of
    true ->
      erlang:apply(string, split, [String, Token, all]);
    false ->
      erlang:apply(string, tokens, [String, Token])
  end.

-spec lowercase(Str :: string()) -> string().
lowercase(String) ->
  case bucs:function_exists(string, lowercase, 1) of
    true ->
      erlang:apply(string, lowercase, [String]);
    false ->
      erlang:apply(string, to_lower, [String])
  end.

-spec uppercase(Str :: string()) -> string().
uppercase(String) ->
  case bucs:function_exists(string, uppercase, 1) of
    true ->
      erlang:apply(string, uppercase, [String]);
    false ->
      erlang:apply(string, to_upper, [String])
  end.
