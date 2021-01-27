#!/usr/bin/pyhton
# -*- coding:utf-8 -*-
# _author:sacus
import paramiko
import os
import time
import warnings
warnings.filterwarnings(action='ignore',module='.*paramiko.*')

a_time=time.time()
ip_list={"zsjefunbm_web2":"10.24.10.147","zsjefunbm_web3":"10.24.10.67","zsjefunbm_web4":"10.24.10.90","zsjefunbm_web5":"10.24.10.96","zsjefunbm_web6":"10.24.10.235","zsjefunbm_web7":"10.24.10.249","zsjefunbm_web8":"10.24.10.212","zsjefunbm_web9":"10.24.10.158","zsjefunbm_web10":"10.24.10.128","zsjefunbm_cron1":"10.24.10.58","zsjefunbm_cron2":"10.24.10.253","zsjefunbm_web11":"10.24.10.5","zsjefunbm_web12":"10.24.10.138","zsjefunbm_web13":"10.24.10.201","zsjefunbm_web14":"10.24.10.33","zsjefunbm_web15":"10.24.10.155","zsjefunbm_web16":"10.24.10.247","zsjefunbm_web17":"10.24.10.64","zsjefunbm_web18":"10.24.10.19","zsjefunbm_web19":"10.24.10.211","zsjefunbm_web20":"10.24.10.106","zsjefunbm_cron3":"10.24.10.176","zsjefunbm_cron4":"10.24.10.55"}
key1='/etc/zabbix/id_rsa'
paramiko.util.log_to_file('/tmp/ssh_log')
md5_file_dst_txt='/tmp/dst_host_txt.md5'
md5_file_src_txt='/tmp/src_host_txt.md5'
diff_file='/tmp/diff_result.md5'
diff_file2='/tmp/diff_result2.md5'
code_dir='/data/www/zsjefunbm/'
exclude_egrep='/\.[a-zA-Z0-9]|Documentation|PHP\ Charting\ Libraries.txt|pb_parser\ -\ 副本.php'
hostname_web1='zsjefunbm_web1'
ssh1_port=22
ssh1_username='king'
tmp_a=1
cmd1='>%s'%(md5_file_dst_txt)
cmd2='>%s'%(diff_file)
os.system(cmd1)
os.system(cmd2)
os.system(">/tmp/ssh_log")
list_exclude=[]
list_exclude_dir=['/data/www/zsjefunbm/s1_zsjefunbm/shell/','/data/www/zsjefunbm/s1_zsjefunbm/config/houtaicfg.bak.ori']

#'find /data/www/gjypmzyw/s1_gjypmzyw/ -type f -name "[a-zA-Z0-9]*" -print |egrep -v "/\.[a-zA-Z0-9]|Documentation|PHP\ Charting\ Libraries.txt|/data/www/gjypmzyw/huodong"|xargs md5sum|sort >/tmp/src_host_txt.md5'
ssh_dst_cmd='find %s -type f -name "[a-zA-Z0-9]*" -print |egrep -v \"%s\"|xargs md5sum|sort >%s'%(code_dir,exclude_egrep,md5_file_dst_txt)
ssh_src_cmd='find %s -type f -name "[a-zA-Z0-9]*" -print |egrep -v \"%s\"|xargs md5sum|sort >%s'%(code_dir,exclude_egrep,md5_file_src_txt)


def ssh_connect(a_hostname,a_username=ssh1_username,a_port=ssh1_port,a_pkey=key1):
	ssh=paramiko.SSHClient()
	ssh_key=paramiko.RSAKey.from_private_key_file(a_pkey)
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	ssh.connect(hostname = a_hostname,port = a_port,username=a_username,pkey=ssh_key)
	stdin,stdout,stderr = ssh.exec_command(ssh_dst_cmd)
	msg_tmp=stdout.read()
	ssh.close()
	return msg_tmp

def ssh_get(a_hostname,a_getname,a_getlocalname,a_username=ssh1_username,a_port=ssh1_port,a_pkey=key1):
	ssh=paramiko.SSHClient()
	ssh_key=paramiko.RSAKey.from_private_key_file(a_pkey)
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	ssh.connect(hostname = a_hostname,port = a_port,username=a_username,pkey=ssh_key)
	a_get=ssh.get_transport()
	sftp=paramiko.SFTPClient.from_transport(a_get)
	sftp.get(a_getname,a_getlocalname)	
	a_get.close()
	ssh.close()
	
os.system(ssh_src_cmd)
cmd1_md5='md5sum %s'%(md5_file_src_txt)
tmp_src_md5=os.popen(cmd1_md5)
tmp_src_md5_value=str(tmp_src_md5.read().split()[0])

dict_src={}
with open(md5_file_src_txt,'r') as f:
	for line in f:
		dict_src[line.split()[1]]=line.split()[0]

if len(list_exclude_dir) > 0:
    for i in list_exclude_dir:
        for j in dict_src.keys():
                if j.startswith(i):
                        try:
                                dict_src.pop(j)
                        except KeyError:
                                pass
for m in list_exclude:
	try:	
		dict_src.pop(m)
	except KeyError:
		pass
for n in ip_list.keys():
	ssh_connect(ip_list[n])
	ssh_get(ip_list[n],md5_file_dst_txt,md5_file_dst_txt)
	cmd2_md5='md5sum %s'%(md5_file_dst_txt)
	tmp_dst_md5=os.popen(cmd2_md5)
	tmp_dst_md5_value=str(tmp_dst_md5.read().split()[0])
	if tmp_src_md5_value == tmp_dst_md5_value: 
		tmp_a = 0
	else:
		dict_dst={}
		with open(md5_file_dst_txt,'r') as f:
			for line in f:
				dict_dst[line.split()[1]] = line.split()[0]	
#web1的文件路径比后面web的文件路径多
		tmp_key=set(dict_src.keys()) - set(dict_dst.keys())
		if tmp_key:
			with open(diff_file,'a+') as f:
				f.write(str(hostname_web1))
				f.write(" more files than ")
				f.write(str(n))
				f.write(" : ")	
				f.write(str(tmp_key))
				f.write("\n")
		
#web1的md5值比后面web的md5值多
		tmp2_key=set(dict_src.values()) - set(dict_dst.values())
		if tmp2_key:
			for m in list(tmp2_key):
				tmp2_key1=list(dict_src.keys())[list(dict_src.values()).index(m)]
				with open(diff_file,'a+') as f:
					f.write(str(hostname_web1))
					f.write(" md5 value diff to ")
					f.write(str(n))
					f.write(" : ")	
					f.write(str(tmp2_key1))
					f.write("\n")
'''
以下两种是反过来比较
		tmp1_key=set(dict_dst.keys()) - set(dict_src.keys())
		if tmp1_key:
			with open(diff_file,'a+') as f:
				f.write(n)
				f.write(" more files than ")
				f.write(str(hostname_web1))
				f.write(": ")
				f.write(str(tmp1_key))
				f.write("\n")
		tmp3_key=set(dict_dst.values()) - set(dict_src.values())
		if tmp3_key:
			for n1 in list(tmp3_key):
				tmp3_key1=list(dict_dst.keys())[list(dict_dst.values()).index(n1)]
				with open(diff_file,'a+') as f:
					f.write(n)
					f.write(" md5 value diff to ")
					f.write(str(hostname_web1))
					f.write(": ")
					f.write(str(tmp3_key1))
					f.write("\n")
					f.write("used second time is: ")
					f.write(str(c_time))
					f.write("\n")
'''
b_time=time.time()
c_time=b_time-a_time		
os.system("cat /tmp/diff_result.md5 >/tmp/diff_result2.md5")
result_file_size=os.path.getsize(diff_file2)
if result_file_size == 0:
	with open(diff_file2,'a+') as f:
		f.write("it is okok")
		f.write("\n")
	
with open(diff_file2,'a+') as f:
	f.write("used second time is: ")
	f.write(str(c_time))
	f.write("\n")
