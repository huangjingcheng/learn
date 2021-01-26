<?php
// https://leetcode-cn.com/problems/two-sum/
class Solution {

    /**
     * @param Integer[] $nums
     * @param Integer $target
     * @return Integer[]
     */
    function twoSum($nums, $target) {
        $map = [];
        foreach($nums as $key => $num){
            $diff = $target - $num;
            if(isset($map[$diff])){
                return [$map[$diff],$key];
            }else{
                $map[$num] = $key;
            }

        }
    }


   /* function twoSum($nums, $target) {
        foreach($nums as $k =>$num1){
            foreach($nums as $kk =>$num2){
                if( $k != $kk && $num1 + $num2 == $target){
                    return  array($k,$kk);
                }   
            }
        }
    }*/


    


}