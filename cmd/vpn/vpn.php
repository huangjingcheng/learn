<?php
$path = str_replace("\\","/",$_SERVER['argv'][1]);
$file = str_replace("\\","/",$_SERVER['argv'][2]);
$str=file_get_contents($file);
$data = explode(PHP_EOL,$str);
$info = array();
foreach($data as $k =>$v){
	if($k % 2 != 1){
		$key = trim(str_replace("PPP adapter ",'',$v),':');
	}else{
		$info[$key] = str_replace("   IPv4 Address. . . . . . . . . . . : ",'',$v);
	}
}
foreach($info as $key =>$ip){
	file_put_contents($path.$key,$ip);
}