<?php
//   https://leetcode-cn.com/problems/number-of-equivalent-domino-pairs/
class Solution {
    /**
     * @param Integer[][] $dominoes
     * @return Integer
     */
    function numEquivDominoPairs($dominoes) {
        if(count($dominoes) <= 1 ){
            return 0;
        }
        $map = [];
        $result = 0;
        foreach($dominoes as &$value){
            sort($value);
            $hash = join('_',$value);
            if(isset($map[$hash])){
                $result += $map[$hash];
                $map[$hash]++;
            }else{
                $map[$hash] = 1;
            }
        }
        return $result;
    }
}
