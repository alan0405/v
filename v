#! /bin/bash

path="/usr/varia"

shellwidth=`stty size|awk '{print $2}'`
hr(){
    yes "-" | sed $shellwidth'q' | tr -d '\n'
}
s1(){
	target="varia"
	if [[ $PATH =~ $target ]] ; then
		echo "已经存在"
	else
		echo "写入.bashrc"
		echo "$pathvalue" >> /root/.bashrc
		bash
	fi
}
setup(){
	path="/usr"
	varia="/usr/varia/"

	pathvalue="export PATH="$PATH:"/usr/varia"

	cd $path

	# 检查git
	if ! type git >/dev/null 2>&1; then
	    yum install -y git
	fi


	if [ -d varia ]
	then
	    echo "开始更新..."
	    hr
	    cd varia
	    git pull
	    hr
	    echo "更新完成"
	else
	    echo "开始下载..."
	    hr
	    git clone https://gitee.com/alan0405/varia.git
	    hr
	    echo "下载完成"
	fi
	echo "添加到PATH"
	s1
	echo "完成"

}

# 没有参数则作为存取工具
if [ $# -eq 0 ]
then
	# 有路径则上传
	if [ -d $path ]
	then
		save
	# 没有路径则下载
	else
		setup
	fi
# 有参数则作为创建编辑工具
else
	#跳转到本目录
	cd /usr/varia

	# 文件存在则编辑
	if [ -f $1 ]
	then
		nano $1
	echo "命令已经编辑,请执行 v 命令上传到gitee"
	# 文件不存在则创建
	else
		echo "#! /bin/bash" > $1
		chmod 777 $1
		nano $1
	echo "新的命令已经创建,请执行 v 命令上传到gitee"
	fi

fi


