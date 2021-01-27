<?php
// https://leetcode-cn.com/problems/binary-subarrays-with-sum/
class Solution {

    /**
     * @param Integer[] $A
     * @param Integer $S
     * @return Integer
     */
    function numSubarraysWithSum($A, $S) {
        $map = [];
        $pre[] = 0;
        $result = 0;
        foreach($A as $k => $v){
            $pre[$k +1 ]= $v + $pre[$k];
        }
        foreach($pre as $k => $v)
        {
            $result += $map[$v-$S];
            $map[$v]++;
        }
        return $result;
        
    }
}
  

$class = new Solution();
$class->numSubarraysWithSum([1,0,1,0],2);