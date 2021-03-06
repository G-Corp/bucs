-module(bucinet).

-export([
         to_ip/1,
         ip_to_string/1,
         ip_to_binary/1,
         active_ip/0,
         active_ips/0,
         loopback/0,
         is_ip/1,
         country/1,
         country/2,
         country/3
        ]).

-type provider() :: ipinfo | ipstack | ipapi.
-type country_options() :: [{string() | binary() | atom(), term()}].

% @doc
% Return a <tt>inet:ip4_address()</tt> from a string or a binary.
% @end
-spec to_ip(binary() | string()) -> inet:ip4_address() | error.
to_ip(IP) when is_binary(IP) ->
  to_ip(bucs:to_list(IP));
to_ip(IP) when is_list(IP) ->
  try
    case [bucs:to_integer(X) || X <- bucstring:split(IP, ".")] of
      [A, B, C, D] when A >= 0, A =< 255,
                        B >= 0, B =< 255,
                        C >= 0, C =< 255,
                        D >= 0, D =< 255 ->
        {A, B, C, D};
      _ -> error
    end
  catch
    _:_ ->
      error
  end;
to_ip({_, _, _, _} = IP) ->
  IP;
to_ip(_) ->
  error.

% @doc
% Return a string for the given <tt>inet:ip4_address()</tt>
% @end
-spec ip_to_string(inet:ip4_address()) -> string() | error.
ip_to_string({A, B, C, D}) when A >= 0, A =< 255,
                                B >= 0, B =< 255,
                                C >= 0, C =< 255,
                                D >= 0, D =< 255 ->
  lists:flatten(io_lib:format("~B.~B.~B.~B", [A, B, C, D]));
ip_to_string(IP) when is_list(IP) ->
  case is_ip(IP) of
    true -> IP;
    false -> error
  end;
ip_to_string(_) ->
  error.

% @doc
% Return a binary for a given <tt>inet:ip4_address()</tt>
% @end
-spec ip_to_binary(inet:ip4_address()) -> binary() | error.
ip_to_binary(IP) when is_binary(IP) ->
  IP;
ip_to_binary(IP) ->
  case ip_to_string(IP) of
    error -> error;
    Str -> bucs:to_binary(Str)
  end.

% @doc
% Return the first active IP (or loopback if none).
% @end
-spec active_ip() -> inet:ip4_address().
active_ip() ->
  case get_active_ips(get_iflist()) of
    [] -> loopback();
    [Ip|_] -> Ip
  end.

% @doc
% Return all actives IPs.
% @end
-spec active_ips() -> [inet:ip4_address()].
active_ips() ->
  get_active_ips(get_iflist()).

% @doc
% Return the loopback IP.
% @end
-spec loopback() -> inet:ip4_address().
loopback() ->
  case get_loopback(get_iflist()) of
    [] -> error;
    [L|_] -> L
  end.

% @doc
% Return true if the given parameter is an IP.
% @end
-spec is_ip(term()) -> true | false.
is_ip({A, B, C, D}) when A >= 0, A =< 255,
                         B >= 0, B =< 255,
                         C >= 0, C =< 255,
                         D >= 0, D =< 255 ->
  true;
is_ip(IP) ->
  error =/= to_ip(IP).

% @doc
% Return the country informations for a given IP address.
% @end
-spec country(inet:ip4_address() | string() | binary()) ->
  {ok, CountryCode :: binary(), CountryName :: binary(), TimeZone :: binary()}
  | {error, term()}.
country(IP) ->
  country([ipapi, ipinfo, ipstack], IP, {error, no_provider}, []).

country([], _, Result, _Options) ->
  Result;
country(_, _, Result, _Options) when element(1, Result) == ok ->
  Result;
country([Provider|Rest], IP, _, Options) ->
  country(Rest, IP, country(Provider, IP, Options), Options).

country_capture(Body, [Part|Rest]) ->
  case re:run(Body, <<"\"", Part/binary, "\": *{([^}]*)}">>, [{capture, [1], binary}]) of
    {match, [<<>>]} -> undefined;
    {match, [C]} -> case Rest of
                      [Data] ->
                        country_capture(C, Data);
                      _ ->
                        country_capture(C, Rest)
                    end;
    _ -> undefined
  end;
country_capture(Body, Name) ->
  case re:run(Body, <<"\"", Name/binary, "\": *\"([^\"]*)\"">>, [{capture, [1], binary}]) of
    {match, [<<>>]} -> undefined;
    {match, [C]} -> C;
    _ -> undefined
  end.

% @doc
% Return the country informations for the given provider or with the given options
%
% To use ipstack, you need to pass your <code>access_key</code> (see https://ipstack.com/product) in the Options.
% @end
-spec country(provider() | inet:ip4_address() | string() | binary(), inet:ip4_address() | string() | binary() | country_options()) ->
  {ok, CountryCode :: binary(), CountryName :: binary(), TimeZone :: binary()}
  | {error, term()}.
country(ipapi, IP) -> country(ipapi, IP, []);
country(ipinfo, IP) -> country(ipinfo, IP, []);
country(ipstack, IP) -> country(ipstack, IP, []);
country(IP, Options) -> country([ipapi, ipinfo, ipstack], IP, {error, no_provider}, Options).

% @hidden
country(ipapi, IP, _Options) ->
  find_country("http://ip-api.com/json/" ++ ip_to_string(IP),
               <<"countryCode">>,
               <<"country">>,
               <<"timezone">>);
country(ipinfo, IP, _Options) ->
  find_country("http://ipinfo.io/" ++ ip_to_string(IP) ++ "/json",
               <<"country">>,
               <<"xxx">>,
               <<"xxx">>);
country(ipstack, IP, Options) ->
  find_country(io_lib:format("http://api.ipstack.com/~s~s", [ip_to_string(IP), country_options([{format, 1}|Options])]),
               <<"country_code">>,
               <<"country_name">>,
               <<"xxx">>).

country_options(Options) ->
  Opts = lists:foldl(fun({Key, Value}, Acc) ->
                  [io_lib:format("~s=~s", [bucs:to_string(Key), bucs:to_string(Value)])|Acc]
              end, [], Options),
  case length(Opts) of
    0 -> "";
    _ -> "?" ++ string:join(Opts, "&")
  end.

find_country(URL, CountryCode, CountryName, Timezone) ->
  case httpc:request(URL) of
    {ok, {{_, 200, _}, _, Body}} ->
      case {ok,
            country_capture(Body, CountryCode),
            country_capture(Body, CountryName),
            country_capture(Body, Timezone)} of
        {ok, undefined, undefined, undefined} ->
          {error, unknow_ip};
        Other ->
          Other
      end;
    {error, _} ->
      {error, ip_server_error}
  end.

% privates

get_active_ips(If_list) ->
  get_ips([A || A <- If_list, inet:ifget(A, [addr]) /= {ok, [{addr, {127, 0, 0, 1}}]}, filter_networkcard(list_to_binary(A))]).

get_iflist() ->
  {ok, IfList} = inet:getiflist(),
  IfList.

filter_networkcard(<<"vboxnet", _R/binary>>) ->
  false;
filter_networkcard(<<"vnic", _R/binary>>) ->
  false;
filter_networkcard(<<"vmnet", _R/binary>>) ->
  false;
filter_networkcard(<<"docker", _R/binary>>) ->
  false;
filter_networkcard(_) ->
  true.

get_ips(A) ->
  get_ips(A, []).

get_ips([], R) ->
  R;
get_ips([If|Rest], R) ->
  case inet:ifget(If, [addr]) of
    {ok, []} -> get_ips(Rest, R);
    {_, [{_, Ip}]} -> get_ips(Rest, [Ip|R])
  end.

get_loopback(If_list) ->
  get_ips([A || A <- If_list, inet:ifget(A, [addr]) == {ok, [{addr, {127, 0, 0, 1}}]}]).
