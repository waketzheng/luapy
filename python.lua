py = {}

function py.join(tab, sep)
    return table.concat(tab, sep)
end

function py.isdigit(str)
    return not str:match('%D')
end

function py.is_blank(str)
    return not str:match('%S')
end

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

function py.bool(any)
    if any == nil then
        return false
    end
    local t = type(any)
    if t == 'table' then
        return not is_empty(any)
    end
    if t == 'string' then
        return any ~= ''
    end
    return any ~= 0
end

function is_empty(tab)
    return next(tab) == nil
end

-- convert table to be a JSON string
-- tb = {a=1}  ==> repr(tb) == '{"a":1}'
function repr(tab,...)
    local i, s, is_list, is_nest = 1, '', true, select('#', ...)
    local pre, sep = '    ', '\n'
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
