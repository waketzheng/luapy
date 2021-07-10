local py = {}

-- 将数组拼接成字符串
-- Example：
--   py=require('python')
--   py.join({ 'a', 'b' }, '/') --> 'a/b'
--   py.join({ 'a', 'b' }) --> 'ab'
py.join = table.concat

-- 把字符串转换成整数
-- Example:
--   py.int('3') --> 3
--   py.int('3.6') --> 3
--   py.int('a', 16) --> 10
function py.int(num, base)
    if type(num) == 'string' then
        if base then
            return math.floor(tonumber(num, (base or 10)))
        end
        return math.floor(tonumber(num, base))
    else
        assert(not base)
        return math.floor(num)
    end
end

-- 判断字符串是否为纯数字
-- Example: py.isdigit('123123') --> true
function py.isdigit(str)
    return not str:match('%D') and str ~= ''
end

-- 判断字符串是否只有空格和换行符、制表符
-- Example: py.is_blank('  \r\n')  --> true
function py.is_blank(str)
    return not str:match('%S')
end

-- 去掉字符串左边的空格
-- Example：py.lstrip(' \r\n abc \r\n') --> 'abc \r\n'
function py.lstrip( s )
    local b = s:match('^%s*(.*)$')
    return b or ''
end

-- 去掉字符串右边的空格
-- Example：py.lstrip(' \r\n abc \r\n') --> ' \r\n abc'
function py.rstrip( s )
    local b = s:match('^(.-)%s*$')
    return b or ''
end

-- 去掉字符串两边的空格
-- Example：py.lstrip(' \r\n abc \r\n') --> 'abc'
function py.strip( s )
    local b = s:match('^%s*(.-)%s*$')
    return b or ''
end

-- 返回一个起点为start，步长为step，终点为stop-step的数组
-- Example:
--   py.range(5) --> {0, 1, 2, 3, 4}
--   py.range(1, 5)  -->  {1, 2, 3, 4}
--   py.range(1, 5, 2) --> {1, 3}
function py.range(start, stop, step)
    -- return list of { start ... stop }
    local i = start
    local ret = {}
    step = step or 1
    if not stop then
        i = 0
        stop = start
    end
    if step > 0 then
        while i < stop do
            table.insert(ret, i)
            i = i + step
        end
    elseif step < 0 then
        while i > stop do
            table.insert(ret, i)
            i = i + step
        end
    else
        print('ValueError: range() arg 3 must not be zero')
    end
    return ret
end

local function is_empty(tab)
    return next(tab) == nil
end

-- 判断table,string是否为空, int是否为零
-- Example：
--   py.bool({}) -> false
--   py.bool(false) -> false
--   py.bool(0) -> false
--   py.bool('') -> false
--   py.bool(' ') -> true
function py.bool(any)
    if not any then
        return false
    end
    local t = type(any)
    if t == 'table' then
        return not is_empty(any)
    elseif t == 'string' then
        return any ~= ''
    end
    return any ~= 0
end

-- 将table转换成内容可见的字符串（只展示前5个元素）
-- tb = {a=1}  ==> repr(tb) == '{"a":1}'
local function repr(tab,...)
    if type(tab) ~= 'table' then return tab end
    local i, s, is_list, is_nest = 1, '', true, select('#', ...)
    local pre, sep, value_type = '    ', '\n'
    if is_nest ~= 0 then
        pre, sep = '', ' '
    end
    for k,v in pairs(tab) do
        if i > 5 then
            s = s..','..sep..pre..'...'
            break
        end
        if i ~= 1 then
            s = s..','
        end
        s = s..sep..pre
        if k ~= i then
            is_list = false
            s = s..'"'..k..'": '
        end
        value_type = type(v)
        if value_type == 'string' then
            v = '"'..v..'"'
        elseif value_type == 'table' then
            v = repr(v, 1)
        end
        s = s..v
        i = i + 1
    end
    if is_list then
        s = '['..s..sep..']'
    else
        s = '{'..s..sep..'}'
    end
    return s
end

py.repr = repr

return py
