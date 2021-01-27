<?php
// https://leetcode-cn.com/problems/add-two-numbers/
/**
 * Definition for a singly-linked list.
 * class ListNode {
 *     public $val = 0;
 *     public $next = null;
 *     function __construct($val = 0, $next = null) {
 *         $this->val = $val;
 *         $this->next = $next;
 *     }
 * }
 */
class Solution {
    /**
     * @param ListNode $l1
     * @param ListNode $l2
     * @return ListNode
     */
    function addTwoNumbers($l1, $l2) {
        $add = 0;
        $headNode = new listNode(0);
        $cur = $headNode;
        while($l1->val !== null || $l2->val !== null || $add){
            $value = 0;
            if($l1->val !== null){
                $value += $l1->val;
                $l1 = $l1->next;
            }
            if($l2->val !== null){
                $value += $l2->val;
                $l2 = $l2->next;
            }
            $value += $add;
            if($value >= 10){
                $add = 1;
            }else{
                $add = 0;
            }
            $cur->next = new listNode($value % 10);
            $cur = $cur->next;
        }
        return $headNode->next;
    }
}