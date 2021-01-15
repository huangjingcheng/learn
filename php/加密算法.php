<?php
$array = array(
	'openId' => '5Wtf2ee80e0',
	'bindData' =>
	array(
		0 =>
		array(
			'bindType' => 'google',
			'bindId' => '',
		),
		1 =>
		array(
			'bindType' => 'apple',
			'bindId' => '',
		),
		2 =>
		array(
			'bindType' => 'facebook',
			'bindId' => '',
		),
		3 =>
		array(
			'bindType' => 'email',
			'bindId' => '',
		),
	),
	'errorCode' => 200,
	'msg' => 'ok',
);

$code = createCode();


$s = encode($array, $code, 10);
decode($s, $code, 10);


function createCode()
{
	$chars = array('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/', '=');
	$data = array();
	foreach ($chars as $i) {
		$data[$i] = createKey();
	}
	return $data;
}

function createKey()
{
	static $info = array();
	do {
		$num = rand(1, 99);
		$flag = str_pad($num, 2, '0', STR_PAD_LEFT);
	} while (isset($info[$flag]));
	$info[$flag] = 1;
	return $flag;
}







function encode($array, $code, $groupNum)
{
	print_r_r("php 数组");
	//print_r($array);
	print_r_r("json 字符串");
	$jsonStr = json_encode($array);
	print_r_r($jsonStr);
	print_r_r("base64 字符串");
	$base64Str = base64_encode($jsonStr);
	print_r_r($base64Str);
	print_r_r("生产数字编码");
	$numStr = '';
	foreach (str_split($base64Str) as $i) {
		$numStr .= $code[$i];
	}
	print_r_r($numStr);
	print_r_r("分组({$groupNum})插位索引");
	$insert = array();
	foreach ($code as $v) {
		$insert[] = $v % $groupNum;
	}
	print_r_r(json_encode($insert));
	print("插位后数字编码");
	$instrNumStr = '';
	foreach (str_split($numStr, $groupNum) as $k => $v) {
		if (isset($insert[$k]) && strlen($v) == $groupNum) {
			$key = array_rand($code);
			$rand = $code[$key] . rand(0, 9);
			echo substr_replace($v, "xx-", $insert[$k], 0), '||';
			$instrNumStr .=  substr_replace($v, $rand, $insert[$k], 0);
		} else {
			echo $v, '||';
			$instrNumStr .= $v;
		}
	}
	echo PHP_EOL;
	print_r_r("插位后数字编码-反转");
	$str = strrev($instrNumStr);
	print_r_r($str);
	return $str;
}
function decode($str, $code, $groupNum)
{
	print_r_r("解码----------");
	print_r_r("插位后数字编码-反转");
	$instrNumStr = strrev($str);
	print_r_r($instrNumStr);
	print_r_r("分组({$groupNum})插位索引");
	$insert = array();
	foreach ($code as $v) {
		$insert[] = $v % $groupNum;
	}
	print_r_r(json_encode($insert));
	print_r_r("删除插位-获得数字编码");
	$numStr = '';
	$num = strlen($code[0]) + 1;
	$groupNum = $groupNum + $num;
	foreach (str_split($instrNumStr, $groupNum) as $k => $v) {
		if (isset($insert[$k]) && strlen($v) == $groupNum) {
			$numStr .=  substr_replace($v, "", $insert[$k], $num);
		} else {
			$numStr .= $v;
		}
	}
	print_r_r($numStr);
	print_r_r("数字编码解析");
	$fcode = array_flip($code);
	$base64Str = '';
	foreach (str_split($numStr, strlen($code[0])) as $i) {
		$base64Str .= $fcode[$i];
	}
	print_r_r($base64Str);
	print_r_r("base64 解析");
	$jsonStr = base64_decode($base64Str);
	print_r_r($jsonStr);
	print_r_r("json 解析");
	$array = json_decode($jsonStr, true);
	//print_r($array);
	return $array;
}

function print_r_r($str)
{
	if (is_array($str)) {
		print_r($str);
	} else {
		echo $str, PHP_EOL;
	}
}
