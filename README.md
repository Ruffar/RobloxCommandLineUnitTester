# What is this?

This is a small piece of code that can be copy and pasted into a Roblox Module Script. It's main purpose is to provide a fast way to unit
test in Roblox Studio which doesn't currently allow for it.

The code can be called by other scripts which are recommended to be module scripts that are called in the editor and not during runtime.

To test, we can call:

```lua
local UnitTester = require(pathTo.UnitTester)
UnitTester.UnitTestBatch(listToTest)
```

Where `listToTest` is a list in the form:

```lua
{ {["function"]: someFunction, ["expectedOutput"]: expectedOutput} }
```

Example:

```lua
local testBatch = {
    {
        ["function"] = function()
	    	return 1+1
		end,
		["expectedOutput"] = 2
    },
    {
		["function"] = function()
	    	return 2/0
		end,
		["expectedOutput"] = 0
    }
}
```

The first test would succeed whereas the second would raise an error.

The expected output can also be set to `UnitTester.ExpectedError` if the test is expected to raise an error. There is no way to distinguish different errors in Lua, so a test is successful if any error is thrown.

```lua
["expectedOutput"] = UnitTester.ExpectedError
```

# How to Use

## Importing to your Roblox place

Copy and paste the contents of UnitTester.lua into a module script in your Roblox place

## Running it on the command line

The recommend way to use this piece of utility is to write another module script that calls the unit test function such as the one below:

```lua
local module = {}

local UnitTester = require(pathTo.UnitTester)

function CalculationsTest.Test()
    UnitTester.UnitTestBatch(module.UnitTestBatch)
end

module.UnitTestBatch = {...}

return module
```

and then testing by running the following code on the command line:

```lua
require(pathTo.module:Clone()).Test()
```

Notice how the module is cloned first as "require"-ing a module script saves it onto the editor cache until it's closed, preventing updates to
carry on with future command line calls.