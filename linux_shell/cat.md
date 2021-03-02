### shell cat 用法

#### 命令格式
```
cat [选项] [文件]...


常用命令参数:
-n 或 --number：由 1 开始对所有输出的行数编号。
-b 或 --number-nonblank：和 -n 相似，只不过对于空白行不编号。
-s 或 --squeeze-blank：当遇到有连续两行以上的空白行，就代换为一行的空白行。
-v 或 --show-nonprinting：使用 ^ 和 M- 符号，除了 LFD 和 TAB 之外。
-E 或 --show-ends : 在每行结束处显示 $。
-T 或 --show-tabs: 将 TAB 字符显示为 ^I。
-A, --show-all：等价于 -vET。
-e：等价于"-vE"选项；
-t：等价于"-vT"选项；
```

#### 功能
```
1.一次显示整个文件。$ cat filename
2.从键盘创建一个文件。$ cat > filename
只能创建新文件,不能编辑已有文件.
3.将几个文件合并为一个文件： $cat file1 file2 > file
```

```
1. 看例子是最快的熟悉方法：
# cat << EOF > test.sh
> #!/bin/bash             #“shell脚本”
> #you Shell script writes here.
> EOF

2. 不同写法而已
# cat > test.sh << EOF 内容  EOF


3. 把 textfile1 和 textfile2 的档案内容加上行号（空白行不加）之后将内容附加到 textfile3 里。
cat -b textfile1 textfile2 >> textfile3

4、非脚本中
如果不是在脚本中，我们可以用Ctrl-D输出EOF的标识
# cat > iii.txt
skldjfklj
sdkfjkl
kljkljklj
kljlk
Ctrl-D
```

