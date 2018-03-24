

# Module bucs #
* [Function Index](#index)
* [Function Details](#functions)

<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#apply-2">apply/2</a></td><td></td></tr><tr><td valign="top"><a href="#apply-3">apply/3</a></td><td></td></tr><tr><td valign="top"><a href="#apply-4">apply/4</a></td><td></td></tr><tr><td valign="top"><a href="#as-2">as/2</a></td><td></td></tr><tr><td valign="top"><a href="#blank-1">blank/1</a></td><td></td></tr><tr><td valign="top"><a href="#call-3">call/3</a></td><td> 
Returns the result of applying Function in Module to Args.</td></tr><tr><td valign="top"><a href="#compare_as_atom-2">compare_as_atom/2</a></td><td></td></tr><tr><td valign="top"><a href="#compare_as_binary-2">compare_as_binary/2</a></td><td></td></tr><tr><td valign="top"><a href="#compare_as_integer-2">compare_as_integer/2</a></td><td></td></tr><tr><td valign="top"><a href="#compare_as_list-2">compare_as_list/2</a></td><td></td></tr><tr><td valign="top"><a href="#compare_as_string-2">compare_as_string/2</a></td><td></td></tr><tr><td valign="top"><a href="#default_to-2">default_to/2</a></td><td></td></tr><tr><td valign="top"><a href="#eval-1">eval/1</a></td><td></td></tr><tr><td valign="top"><a href="#eval-2">eval/2</a></td><td></td></tr><tr><td valign="top"><a href="#function_exist-3">function_exist/3</a></td><td></td></tr><tr><td valign="top"><a href="#function_exists-3">function_exists/3</a></td><td>
Check if the given function exist.</td></tr><tr><td valign="top"><a href="#is_kw_list-1">is_kw_list/1</a></td><td>
Check if the given value is a keyword list.</td></tr><tr><td valign="top"><a href="#is_list_of_lists-1">is_list_of_lists/1</a></td><td>
Check if the given value is a list of lists.</td></tr><tr><td valign="top"><a href="#is_string-1">is_string/1</a></td><td>
Check if the given value is a string.</td></tr><tr><td valign="top"><a href="#is_tuple_of-2">is_tuple_of/2</a></td><td></td></tr><tr><td valign="top"><a href="#is_type-2">is_type/2</a></td><td></td></tr><tr><td valign="top"><a href="#match-2">match/2</a></td><td>
Return true if <tt>A</tt> match <tt>B</tt>.</td></tr><tr><td valign="top"><a href="#module_exist-1">module_exist/1</a></td><td></td></tr><tr><td valign="top"><a href="#module_exists-1">module_exists/1</a></td><td>
Check if the given module exist.</td></tr><tr><td valign="top"><a href="#pipecall-1">pipecall/1</a></td><td> 
Pipe fun call.</td></tr><tr><td valign="top"><a href="#present-1">present/1</a></td><td></td></tr><tr><td valign="top"><a href="#to-2">to/2</a></td><td></td></tr><tr><td valign="top"><a href="#to_atom-1">to_atom/1</a></td><td> 
Convert the given term to atom.</td></tr><tr><td valign="top"><a href="#to_binary-1">to_binary/1</a></td><td> 
Convert the given term to binary.</td></tr><tr><td valign="top"><a href="#to_float-1">to_float/1</a></td><td> 
Convert the given term to float.</td></tr><tr><td valign="top"><a href="#to_float-2">to_float/2</a></td><td> 
Convert the given term to float, with the given precision.</td></tr><tr><td valign="top"><a href="#to_integer-1">to_integer/1</a></td><td> 
Convert the given term to integer.</td></tr><tr><td valign="top"><a href="#to_list-1">to_list/1</a></td><td> 
Convert the given term to list.</td></tr><tr><td valign="top"><a href="#to_string-1">to_string/1</a></td><td>
Convert the given term to string.</td></tr><tr><td valign="top"><a href="#to_term-1">to_term/1</a></td><td> 
Convert the given value to term.</td></tr><tr><td valign="top"><a href="#type-1">type/1</a></td><td></td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="apply-2"></a>

### apply/2 ###

`apply(Fun, Args) -> any()`

<a name="apply-3"></a>

### apply/3 ###

`apply(Fun, Args, Default) -> any()`

<a name="apply-4"></a>

### apply/4 ###

`apply(Module, Function, Args, Default) -> any()`

<a name="as-2"></a>

### as/2 ###

`as(Type, Data) -> any()`

<a name="blank-1"></a>

### blank/1 ###

`blank(M) -> any()`

<a name="call-3"></a>

### call/3 ###

<pre><code>
call(Module::module(), Function::atom(), Args::[term()]) -&gt; term() | {error, undefined_function}
</code></pre>
<br />


Returns the result of applying Function in Module to Args. The applied 
function must be exported from Module. The arity of the function is the length of Args.

Return `{error, undefined_function}` if the applied function is not exported.

<a name="compare_as_atom-2"></a>

### compare_as_atom/2 ###

`compare_as_atom(V1, V2) -> any()`

<a name="compare_as_binary-2"></a>

### compare_as_binary/2 ###

`compare_as_binary(V1, V2) -> any()`

<a name="compare_as_integer-2"></a>

### compare_as_integer/2 ###

`compare_as_integer(V1, V2) -> any()`

<a name="compare_as_list-2"></a>

### compare_as_list/2 ###

`compare_as_list(V1, V2) -> any()`

<a name="compare_as_string-2"></a>

### compare_as_string/2 ###

`compare_as_string(V1, V2) -> any()`

<a name="default_to-2"></a>

### default_to/2 ###

`default_to(X, Default) -> any()`

<a name="eval-1"></a>

### eval/1 ###

`eval(Value) -> any()`

<a name="eval-2"></a>

### eval/2 ###

`eval(Value, Environ) -> any()`

<a name="function_exist-3"></a>

### function_exist/3 ###

`function_exist(Module, Function, Arity) -> any()`

<a name="function_exists-3"></a>

### function_exists/3 ###

`function_exists(Module, Function, Arity) -> any()`

Check if the given function exist

<a name="is_kw_list-1"></a>

### is_kw_list/1 ###

`is_kw_list(V) -> any()`

Check if the given value is a keyword list

<a name="is_list_of_lists-1"></a>

### is_list_of_lists/1 ###

`is_list_of_lists(L) -> any()`

Check if the given value is a list of lists

<a name="is_string-1"></a>

### is_string/1 ###

`is_string(V) -> any()`

Check if the given value is a string

<a name="is_tuple_of-2"></a>

### is_tuple_of/2 ###

`is_tuple_of(Tuple, Pattern) -> any()`

<a name="is_type-2"></a>

### is_type/2 ###

`is_type(Data, Type) -> any()`

<a name="match-2"></a>

### match/2 ###

`match(A, B) -> any()`

Return true if `A` match `B`. false otherwise.

<a name="module_exist-1"></a>

### module_exist/1 ###

`module_exist(Module) -> any()`

<a name="module_exists-1"></a>

### module_exists/1 ###

`module_exists(Module) -> any()`

Check if the given module exist

<a name="pipecall-1"></a>

### pipecall/1 ###

`pipecall(Rest) -> any()`


Pipe fun call

Example:

```

 Add = math:pow(7, 3),
 Log = math:log(Add),
 Mul = multiplication(Log, 7),
 Res = addition(Mul, 7).

 % With bucs:pipecall/1 :
 Res = bucs:pipecall([
                      {fun math:pow/2, [7, 3]},
                      fun math:log/1,
                      {fun multiplication/2, [7]},
                      {fun addition/2, [7]}
                     ]).
```

<a name="present-1"></a>

### present/1 ###

`present(X) -> any()`

<a name="to-2"></a>

### to/2 ###

`to(X1, Data) -> any()`

<a name="to_atom-1"></a>

### to_atom/1 ###

`to_atom(X) -> any()`


Convert the given term to atom

Example:

```

 atom = bucs:to_atom(atom).
 atom = bucs:to_atom(<<"atom">>).
 atom = bucs:to_atom("atom").
```

<a name="to_binary-1"></a>

### to_binary/1 ###

`to_binary(V) -> any()`


Convert the given term to binary

Example:

```

 <<"list">> = bucs:to_binary(list).
 <<"list">> = bucs:to_binary("list").
 <<"list">> = bucs:to_binary(<<"list">>).
 <<"123">> = bucs:to_binary(123).
 <<"1.20000000000000000000e+01">> = bucs:to_binary(12.0).
 <<"true">> = bucs:to_binary(true).
 <<"false">> = bucs:to_binary(false).
```

<a name="to_float-1"></a>

### to_float/1 ###

`to_float(Value) -> any()`


Convert the given term to float

Example

```

 123.45 = bucs:to_float(123.45).
 123.45 = bucs:to_float("123.45").
 123.45 = bucs:to_float(<<"123.45">>).
 123.45 = bucs:to_float('123.45').
 123.0 = bucs:to_float(123).
```

<a name="to_float-2"></a>

### to_float/2 ###

`to_float(Value, Precision) -> any()`


Convert the given term to float, with the given precision

Example

```

 123.457 = bucs:to_float(123.45678i, 3).
 123.457 = bucs:to_float("123.45678", 3).
 123.457 = bucs:to_float(<<"123.45678">>, 3).
 123.457 = bucs:to_float('123.45678', 3).
 123.0 = bucs:to_float(123, 3).
```

<a name="to_integer-1"></a>

### to_integer/1 ###

`to_integer(I) -> any()`


Convert the given term to integer

Example

```

 123 = bucs:to_integer(123).
 123 = bucs:to_integer("123").
 123 = bucs:to_integer(<<"123">>).
 123 = bucs:to_integer('123').
 123 = bucs:to_integer(123.456).
```

<a name="to_list-1"></a>

### to_list/1 ###

`to_list(V) -> any()`


Convert the given term to list

Example:

```

 "list" = bucs:to_list(list).
 "list" = bucs:to_list("list").
 "list" = bucs:to_list(<<"list">>).
 "123" = bucs:to_list(123).
 "1.20000000000000000000e+01" = bucs:to_list(12.0).
 "true" = bucs:to_list(true).
 "false" = bucs:to_list(false).
```

<a name="to_string-1"></a>

### to_string/1 ###

`to_string(V) -> any()`

Convert the given term to string

<a name="to_term-1"></a>

### to_term/1 ###

`to_term(Value) -> any()`


Convert the given value to term

Example

```
<p></p>
```

<a name="type-1"></a>

### type/1 ###

`type(Data) -> any()`

