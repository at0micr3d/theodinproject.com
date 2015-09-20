#Part of (the odin project)[http://www.theodinproject.com/ruby-programming/testing-ruby]
##Your Task
1. Go back to the Building Blocks Project and write tests for your "Caesar's Cipher" code. It shouldn't take more than a half-dozen tests to cover all the possible cases. Do you remember how to make your tests run using $ rake?

2. Go back to the Advanced Building Blocks Project and write tests for any 6 of the enumerable methods you wrote there. In this case, identify several possible inputs for each of those functions and test to make sure that your implementation of them actually makes the tests pass. Be sure to try and cover some of the odd edge cases where you can.

3. Write tests for your Tic Tac Toe project. In this situation, it's not quite as simple as just coming up with inputs and making sure the method returns the correct thing. You'll need to make the tests determine victory or loss conditions are correctly assessed.
-Start by writing tests to make sure players win when they should, e.g. when the board reads X X X across the top row, your #game-over method (or its equivalent) should trigger.
-Test each of your critical methods to make sure they function properly and handle edge cases.
-Try using mocks/doubles to isolate methods and make sure that they're sending back the right outputs.
