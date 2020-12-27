<?php
class createList
{
    private $removeConfig = array(
        '.vscode' => 1,
        '.git' => 1
    );
    private $extensionName = array(
        'md' => 1,
    );
    private $data = array();

    public  function scandirFolder($path)
    {
        $temp_list = scandir($path);
        foreach ($temp_list as $file) {
            if ($file != ".." && $file != ".") {
                if (is_dir($path . "/" . $file)) {
                    //子文件夹，进行递归
                    if (!isset($this->removeConfig[$file])) {
                        $this->data[$path . "/" . $file] = array(
                            'dir' => $file,
                            'info' => array()
                        );
                        $this->scandirFolder($path . "/" . $file);
                    }
                } else {
                    //根目录下的文件
                    $extension = pathinfo($file, PATHINFO_EXTENSION);
                    if (isset($this->extensionName[$extension])) {
                        $this->data[$path]['info'][] = $file;
                    }
                }
            }
        }
    }
    public function create()
    {
        print_r($this->data);
    }
}
$createList = new createList();
$createList->scandirFolder("./..");
$createList->create();
