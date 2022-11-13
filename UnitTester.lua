local UnitTester = {}


UnitTester.ExpectedError = Enum.Status.Poison --The enum chosen is arbitrary, but we use it as a hacky way to make our own enum by using a deprecated enum


function DisplayError(testNo, err)
	warn("Test "..testNo.." failed! Error occured:", err)
end

function UnitTester.UnitTestBatch(tests: {{ ["function"]: (...any)->...any, ["expectedOutput"]: any }} )
	--Input must be an list
	
	local successfulTests = 0
	
	for i, test in pairs(tests) do
		local success, response = xpcall(
			test["function"], --Function the test uses
			function(err) DisplayError(i, err) end --Error handler
		)
		
		if success then
			if response ~= test["expectedOutput"] then
				warn("Test "..i.." failed! Wrong output:", response)
			else
				print("Test "..i.." successful!")
				successfulTests += 1
			end
        elseif test["expectedOutput"] == UnitTester.ExpectedError then
			successfulTests += 1
		end
	end
	
	print(successfulTests.."/"..#tests.." Tests were succesful!")
	
end

return UnitTester
