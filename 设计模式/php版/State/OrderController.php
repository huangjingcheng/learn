<?php
//  状态模式  --- 行为型
namespace DesignPatterns\Behavioral\State;

/**
 * OrderController类
 */
class OrderController
{
    /**
     * @param int $id
     */
    public function shipAction($id)
    {
        $order = OrderFactory::getOrder($id);
        try {
            $order->shipOrder();
        } catch (Exception $e) {
            //处理错误!
        }
        // 发送响应到浏览器
    }

    /**
     * @param int $id
     */
    public function completeAction($id)
    {
        $order = OrderFactory::getOrder($id);
        try {
            $order->completeOrder();
        } catch (Exception $e) {
            //处理错误!
        }
        // 发送响应到浏览器
    }
}