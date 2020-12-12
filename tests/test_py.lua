local lu = require('luaunit')
local py = require('python')

TestListCompare = {}
    function TestListCompare:test_is_blank()
        lu.assertError(py.is_blank, nil)  -- arg can only be string
        lu.assertError(py.is_blank, {})
        lu.assertError(py.is_blank, 0)

        lu.assertEquals(true, py.is_blank(''))
        lu.assertEquals(true, py.is_blank(' '))
        lu.assertEquals(true, py.is_blank('    '))
        lu.assertEquals(true, py.is_blank('\n'))
        lu.assertEquals(true, py.is_blank('    \n'))

        lu.assertEquals(py.is_blank('1'), false)
        lu.assertEquals(py.is_blank('a'), false)
    end

    function TestListCompare:test_strip()
        lu.assertError(py.strip, nil)  -- arg can only be string
        lu.assertError(py.strip, {})
        lu.assertError(py.strip, 0)

        lu.assertEquals('1', py.strip(' 1 '))
        lu.assertEquals('', py.strip(' '))
        lu.assertEquals(' 1', py.rstrip(' 1 '))
        lu.assertEquals('1 ', py.lstrip(' 1 '))
        lu.assertEquals('2', py.strip('\n \r\t 2 \n\r\t '))
        lu.assertEquals('3 3', py.strip('  3 3  \n'))

        lu.assertEquals(py.strip('\n1\n2 3\r4 '), '1\n2 3\r4')
        lu.assertEquals(py.strip('a'), 'a')
        lu.assertEquals(py.lstrip('a'), 'a')
        lu.assertEquals(py.rstrip('a'), 'a')
    end

    function TestListCompare:test_isdigit()
        lu.assertError(py.isdigit, nil)  -- arg can only be string
        lu.assertError(py.isdigit, {})
        lu.assertError(py.isdigit, 0)

        lu.assertEquals(false, py.isdigit(''))
        lu.assertEquals(false, py.isdigit(' '))
        lu.assertEquals(false, py.isdigit('    '))
        lu.assertEquals(false, py.isdigit('\n'))
        lu.assertEquals(false, py.isdigit('    \n'))
        lu.assertEquals(false, py.isdigit('1111    \n'))
        lu.assertEquals(false, py.isdigit('1111aaa'))
        lu.assertEquals(false, py.isdigit('aa1111'))
        lu.assertEquals(false, py.isdigit('1.0'))
        lu.assertEquals(false, py.isdigit('-1'))
        lu.assertEquals(false, py.isdigit('+1'))

        lu.assertEquals(py.isdigit('1'), true)
        lu.assertEquals(py.isdigit('0'), true)
        lu.assertEquals(py.isdigit('0000'), true)
        lu.assertEquals(py.isdigit('00001'), true)
        lu.assertEquals(py.isdigit('2123123'), true)
    end

    function TestListCompare:test_range()
        lu.assertEquals(py.repr(py.range(3)), py.repr({ 0, 1, 2 }))
        lu.assertEquals(py.repr(py.range(1, 3)), py.repr({ 1, 2 }))
        lu.assertEquals(py.repr(py.range(1, 5, 2)), py.repr({ 1, 3 }))
        lu.assertEquals(py.repr(py.range(5, 1, -2)), py.repr({ 5, 3 }))
    end

    function TestListCompare:test_repr()
        lu.assertEquals(py.repr({ 0, 1, 2 }), '[\n    0,\n    1,\n    2\n]')
        expected = {
            '{\n    "a": 1,\n    "b": 2\n}',
            '{\n    "b": 2,\n    "a": 1\n}'
        }
        lu.assertTableContains(expected, py.repr({ a=1, b=2 }))
    end

    function TestListCompare:test_join()
        lu.assertEquals(py.join({ 0, 1, 2 }), '012')
        lu.assertEquals(py.join({ 0, 1, 2 }, ''), '012')
        lu.assertEquals(py.join({ 0, 1, 2 }, ' '), '0 1 2')
        lu.assertEquals(py.join({ 0, 1, 2 }, ', '), '0, 1, 2')
        lu.assertEquals(py.join({ 0 }, ', '), '0')

        lu.assertEquals(py.join({ a=1, b=2 }), '')
        lu.assertEquals(py.join({ a=1, b=2 }, ', '), '')
    end

    function TestListCompare:test_bool()
        lu.assertEquals(py.bool(nil), false)
        lu.assertEquals(py.bool(false), false)
        lu.assertEquals(py.bool(''), false)
        lu.assertEquals(py.bool(0), false)
        lu.assertEquals(py.bool(0.0), false)
        lu.assertEquals(py.bool({}), false)

        lu.assertEquals(py.bool(true), true)
        lu.assertEquals(py.bool(' '), true)
        lu.assertEquals(py.bool('\n'), true)
        lu.assertEquals(py.bool(1), true)
        lu.assertEquals(py.bool(py.bool), true)
        lu.assertEquals(py.bool({1}), true)
        lu.assertEquals(py.bool({0}), true)
    end
os.exit( lu.run() )
