local UnitTester = {}

function UnitTester.DisplayError(testNo, err)
	warn("Test "..testNo.." failed! Error occured:", err)
end

function UnitTester.UnitTestBatch(tests: {{ ["function"]: (...any)->...any, ["expectedOutput"]: any }} )
	--Input must be an array
	
	local successfulTests = 0
	
	for i, test in pairs(tests) do
		local success, response = xpcall(
			test["function"], --Function the test uses
			function(err) UnitTester.DisplayError(i, err) end --Error handler
		)
		
		if success then
			if response ~= test["expectedOutput"] then
				warn("Test "..i.." failed! Wrong output:", response)
			else
				print("Test "..i.." successful!")
				successfulTests += 1
			end
		end
	end
	
	print(successfulTests.."/"..#tests.." Tests were succesful!")
	
end

return UnitTester
