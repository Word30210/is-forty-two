local test = require("@std/test")

local lib = require("../src/lib")

test.suite("is-forty-two", function()
    test.case("fortytwo", function(asserts)
        local is = lib.is

        asserts.eq(is(42):fortytwo(), true)
        asserts.eq(is(41.5):fortytwo(), false)
        asserts.eq(is(67):fortytwo(), false)
    end)

    test.case("roughly", function(asserts)
        local is = lib.is

        asserts.eq(is(41.5):fortytwo(), false)
        asserts.eq(is(41.5):roughly():fortytwo(), true)
    end)

    test.case("not", function(asserts)
        local is = lib.is

        asserts.eq(is(42):nt():fortytwo(), false)
        asserts.eq(is(41.5):nt():fortytwo(), true)
        asserts.eq(is(67):nt():fortytwo(), true)
    end)
end)

return nil