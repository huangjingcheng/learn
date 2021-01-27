<?php
// https://leetcode-cn.com/problems/maximal-rectangle/
class Solution
{

        /**
         * @param String[][] $matrix
         * @return Integer
         */
        function maximalRectangle($matrix)
        {

                $len = count($matrix);
                $width = count($matrix[0]);
                $data = [];
                $res = 0;
                for ($i = 0; $i < $width; $i++) {
                        for ($j = 0; $j < $len; $j++) {
                                if ($matrix[$j][$i] == "0") {
                                        $data[$j][$i] = 0;
                                } else {
                                        $data[$j][$i] = isset($data[$j - 1][$i]) && $data[$j - 1][$i] ? $data[$j - 1][$i] + 1 : 1;
                                }
                        }
                }
                foreach ($data as $value) {
                        $res = max($res, $this->area($value));
                }
                return $res;
        }
        /**
         * @param Array heights
         * @return Integer 
         */
        function area($heights)
        {
                array_push($heights, 0);
                $stack = new SplStack;
                $max = 0;
                for ($i = 0; $i < count($heights); $i++) {
                        while (!$stack->isEmpty() && $heights[$stack->top()] >= $heights[$i]) {
                                $last = $stack->pop();
                                if (!$stack->isEmpty()) {
                                        $width = $i - $stack->top() - 1;
                                } else {
                                        $width = $i;
                                }
                                $max = max($max, $heights[$last] * $width);
                        }
                        $stack->push($i);
                }
                return $max;
        }
}
$matrix = [["1", "0", "1", "0", "0"], ["1", "0", "1", "1", "1"], ["1", "1", "1", "1", "1"], ["1", "0", "0", "1", "0"]];
$class = new Solution();
$result = $class->maximalRectangle($matrix);
print_r($result);
