<?php

namespace DesignPatterns\Behavioral\State;

/**
 * OrderInterface接口
 */
interface OrderInterface
{
    /**
     * @return mixed
     */
    public function shipOrder();

    /**
     * @return mixed
     */
    public function completeOrder();
}