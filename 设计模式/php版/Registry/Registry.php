<?php

namespace DesignPatterns\Structural\Registry;

/**
 * class Registry  注册模式  注册树模式
 */
abstract class Registry
{
    const LOGGER = 'logger';

    /**
     * @var array
     */
    protected static $storedValues = array();

    /**
     * sets a value
     *
     * @param string $key
     * @param mixed  $value
     *
     * @static
     * @return void
     */
    public static function set($key, $value)
    {
        self::$storedValues[$key] = $value;
    }

    /**
     * gets a value from the registry
     *
     * @param string $key
     *
     * @static
     * @return mixed
     */
    public static function get($key)
    {
        return self::$storedValues[$key];
    }

    // typically there would be methods to check if a key has already been registered and so on ...
}