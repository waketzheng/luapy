# LuaPy
Some python function for Lua

Example of bool

```
> py=require('python')
> py.bool('')
false
> py.bool(' ')
true
> py.bool(0)
false
> py.bool(1)
true
> py.bool(0.0)
false
> py.bool(py.bool)
true
> py.bool({})
false
> py.bool({1})
true
> py.bool({0})
true
```

Example of repr (convert table to string, but just display the first five elements)

```
> tab = { 1, 2, 3 }
> py.repr(tab)
[
    1,
    2,
    3
]
> tab = { a=1, b=2, c=3 }
> py.repr(tab)
{
    "c": 3,
    "a": 1,
    "b": 2
}
> tab = { a='a', b='b', c='c', d='d', e='e', f='f', g='g' }
> py.repr(tab)
{
    "g": "g",
    "a": "a",
    "b": "b",
    "c": "c",
    "d": "d",
    ...
}
```

Example of range

```
> py.repr(py.range(3))
[
    0,
    1,
    2
]
> py.repr(py.range(1,3))
[
    1,
    2
]
> py.repr(py.range(1,5,2))
[
    1,
    3
]
> py.repr(py.range(5,1,-2))
[
    5,
    3
]
```
