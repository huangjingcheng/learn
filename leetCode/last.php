<?php

class Solution
{

    /**
     * @param Integer[] $stones
     * @return Integer
     */
    function lastStoneWeight($stones)
    {
        $heap = new SplMaxHeap();
        foreach($stones as $stone){
            $heap->insert($stone);
        }
        while($heap->count() > 1){
            $heap1 = $heap->extract();
            $heap2 = $heap->extract();
            $tmp = $heap1 - $heap2;
            if($tmp > 0){
                $heap->insert($tmp);
            }
        }
        return $heap->count() == 0 ? 0 : $heap->extract(); 
    }
}
$class = new Solution();
$result = $class->lastStoneWeight([2,7,4,1,8,1]);
print_r($result);
