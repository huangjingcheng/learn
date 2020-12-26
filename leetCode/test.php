<?php
class Solution {

/**
 * @param String[][] $matrix
 * @return Integer
 */
function maximalRectangle($matrix) {
        print_r($matrix);
}
}
$matrix = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]];
$class = new Solution();
$class->maximalRectangle($matrix);