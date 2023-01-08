// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13;

import "src/SD59x18.sol";
import { SD59x18_Test } from "../../SD59x18.t.sol";

contract Abs_Test is SD59x18_Test {
    function test_Abs_Zero() external {
        SD59x18 x = ZERO;
        SD59x18 actual = abs(x);
        SD59x18 expected = ZERO;
        assertEq(actual, expected);
    }

    modifier NotZero() {
        _;
    }

    function test_RevertWhen_MinSD59x18() external NotZero {
        SD59x18 x = MIN_SD59x18;
        vm.expectRevert(abi.encodeWithSelector(PRBMathSD59x18__AbsMinSD59x18.selector));
        abs(x);
    }

    modifier NotMinSD59x18() {
        _;
    }

    function negative_Sets() internal returns (Set[] memory) {
        delete sets;
        sets.push(set({ x: MIN_SD59x18.add(sd(1)), expected: MAX_SD59x18 }));
        sets.push(set({ x: MIN_WHOLE_SD59x18, expected: MAX_WHOLE_SD59x18 }));
        sets.push(set({ x: -1e24, expected: 1e24 }));
        sets.push(set({ x: -4.2e18, expected: 4.2e18 }));
        sets.push(set({ x: NEGATIVE_PI, expected: PI }));
        sets.push(set({ x: -2e18, expected: 2e18 }));
        sets.push(set({ x: -1.125e18, expected: 1.125e18 }));
        sets.push(set({ x: -1e18, expected: 1e18 }));
        sets.push(set({ x: -0.5e18, expected: 0.5e18 }));
        sets.push(set({ x: -0.1e18, expected: 0.1e18 }));
        return sets;
    }

    function test_Abs_Negative() external parameterizedTest(negative_Sets()) NotZero NotMinSD59x18 {
        SD59x18 actual = abs(s.x);
        assertEq(actual, s.expected);
    }

    function positive_Sets() internal returns (Set[] memory) {
        delete sets;
        sets.push(set({ x: 0.1e18, expected: 0.1e18 }));
        sets.push(set({ x: 0.5e18, expected: 0.5e18 }));
        sets.push(set({ x: 1e18, expected: 1e18 }));
        sets.push(set({ x: 1.125e18, expected: 1.125e18 }));
        sets.push(set({ x: 2e18, expected: 2e18 }));
        sets.push(set({ x: PI, expected: PI }));
        sets.push(set({ x: 4.2e18, expected: 4.2e18 }));
        sets.push(set({ x: 1e24, expected: 1e24 }));
        sets.push(set({ x: MAX_WHOLE_SD59x18, expected: MAX_WHOLE_SD59x18 }));
        sets.push(set({ x: MAX_SD59x18, expected: MAX_SD59x18 }));
        return sets;
    }

    function test_Abs() external parameterizedTest(positive_Sets()) NotZero NotMinSD59x18 {
        SD59x18 actual = abs(s.x);
        assertEq(actual, s.expected);
    }
}
