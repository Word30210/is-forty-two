--[=[
    @class Checker

    Used for checking if a number is equal to forty-two, or roughly equal to forty-two.
]=]
local Checker = {}
local CheckerPrototype = table.freeze({
    __index = Checker;
})

export type Checker = setmetatable<{
    read value: number;
    read _roughly: boolean;
    read _nt: boolean;
}, typeof(CheckerPrototype)>

--[=[
    Creates a new Checker for the given number.

    @function is
    @within Checker

    @param number number -- The number to check.
    @return Checker

    @tag constructor
]=]
local function new(number: number): Checker
    return table.freeze(setmetatable({
        value = number;
        _roughly = false;
        _nt = false;
    }, CheckerPrototype))
end

--[=[
    Checks if the number is equal to forty-two, or roughly equal to forty-two.

    @method fortytwo
    @within Checker

    @return boolean

    **Example:**
    ```lua
    local is = require(path.to.lib).is

    is(42):fortytwo() -- true
    is(41.5):fortytwo() -- false
    is(67):fortytwo() -- false
    ```
]=]
function Checker.fortytwo(self: Checker): boolean
    local res: boolean

    if self._roughly then
        res = self.value - 42 <= 0.5
    else
        res = self.value == 42
    end

    return
        if self._nt
        then not res
        else res
end

--[=[
    Checks if the number is roughly equal to forty-two.

    @method roughly
    @within Checker

    @return Checker

    **Example:**
    ```lua
    local is = require(path.to.lib).is

    is(41.5):fortytwo() -- false
    is(41.5):roughly():fortytwo() -- true
    ```
]=]
function Checker.roughly(self: Checker): Checker
    return table.freeze(setmetatable({
        value = self.value;
        _roughly = true;
        _nt = self._nt;
    }, CheckerPrototype))
end

--[=[
    Negates the check.

    @method nt
    @within Checker

    @return Checker

    **Example:**
    ```lua
    local is = require(path.to.lib).is

    is(42):nt():fortytwo() -- false
    is(41.5):nt():roughly():fortytwo() -- false
    is(67):nt():fortytwo() -- true
    ```
]=]
function Checker.nt(self: Checker): Checker
    return table.freeze(setmetatable({
        value = self.value;
        _roughly = self._roughly;
        _nt = not self._nt;
    }, CheckerPrototype))
end

return {
    is = new;
}