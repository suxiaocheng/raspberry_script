#!/bin/bash

# 电话键
# KEYCODE_CALL: 拨号键
# KEYCODE_ENDCALL: 挂机键
# KEYCODE_HOME: 按键Home
# KEYCODE_MENU: 菜单键
# KEYCODE_BACK: 返回键
# KEYCODE_SEARCH: 搜索键
# KEYCODE_CAMERA: 拍照键
# KEYCODE_FOCUS: 拍照对焦键
# KEYCODE_POWER: 电源键
# KEYCODE_NOTIFICATION: 通知键
# KEYCODE_MUTE: 话筒静音键
# KEYCODE_VOLUME_MUTE: 扬声器静音键
# KEYCODE_VOLUME_UP: 音量增加键
# KEYCODE_VOLUME_DOWN: 音量减小键
# 
# 控制键
# KEYCODE_ENTER: 回车键
# KEYCODE_ESCAPE: ESC键
# KEYCODE_DPAD_CENTER: 导航键 确定键
# KEYCODE_DPAD_UP: 导航键 向上
# KEYCODE_DPAD_DOWN: 导航键 向下
# KEYCODE_DPAD_LEFT: 导航键 向左
# KEYCODE_DPAD_RIGHT: 导航键 向右
# KEYCODE_MOVE_HOME: 光标移动到开始键
# KEYCODE_MOVE_END: 光标移动到末尾键
# KEYCODE_PAGE_UP: 向上翻页键
# KEYCODE_PAGE_DOWN: 向下翻页键
# KEYCODE_DEL: 退格键
# KEYCODE_FORWARD_DEL: 删除键
# KEYCODE_INSERT: 插入键
# KEYCODE_TAB: Tab键
# KEYCODE_NUM_LOCK: 小键盘锁
# KEYCODE_CAPS_LOCK: 大写锁定键
# KEYCODE_BREAK: Break/Pause键
# KEYCODE_SCROLL_LOCK: 滚动锁定键
# KEYCODE_ZOOM_IN: 放大键
# KEYCODE_ZOOM_OUT: 缩小键
# 
# 基本键
# KEYCODE_0: 按键'0'
# KEYCODE_1: 按键'1'
# KEYCODE_2: 按键'2'
# KEYCODE_3: 按键'3'
# KEYCODE_4: 按键'4'
# KEYCODE_5: 按键'5'
# KEYCODE_6: 按键'6'
# KEYCODE_7: 按键'7'
# KEYCODE_8: 按键'8'
# KEYCODE_9: 按键'9'
# KEYCODE_A: 按键'A'
# KEYCODE_B: 按键'B'
# KEYCODE_C: 按键'C'
# KEYCODE_D: 按键'D'
# KEYCODE_E: 按键'E'
# KEYCODE_F: 按键'F'
# KEYCODE_G: 按键'G'
# KEYCODE_H: 按键'H'
# KEYCODE_I: 按键'I'
# KEYCODE_J: 按键'J'
# KEYCODE_K: 按键'K'
# KEYCODE_L: 按键'L'
# KEYCODE_M: 按键'M'
# KEYCODE_N: 按键'N'
# KEYCODE_O: 按键'O'
# KEYCODE_P: 按键'P'
# KEYCODE_Q: 按键'Q'
# KEYCODE_R: 按键'R'
# KEYCODE_S: 按键'S'
# KEYCODE_T: 按键'T'
# KEYCODE_U: 按键'U'
# KEYCODE_V: 按键'V'
# KEYCODE_W: 按键'W'
# KEYCODE_X: 按键'X'
# KEYCODE_Y: 按键'Y'
# KEYCODE_Z: 按键'Z'
# 
# 符号
# KEYCODE_PLUS: 按键'+'
# KEYCODE_MINUS: 按键'-'
# KEYCODE_STAR: 按键'*'
# KEYCODE_SLASH: 按键'/'
# KEYCODE_EQUALS: 按键'='
# KEYCODE_AT: 按键'@'
# KEYCODE_POUND: 按键'#'
# KEYCODE_APOSTROPHE: 按键''' (单引号)
# KEYCODE_BACKSLASH: 按键'\'
# KEYCODE_COMMA: 按键','
# KEYCODE_PERIOD: 按键'.'
# KEYCODE_LEFT_BRACKET: 按键'['
# KEYCODE_RIGHT_BRACKET: 按键']'
# KEYCODE_SEMICOLON: 按键';'
# KEYCODE_GRAVE: 按键'`'
# KEYCODE_SPACE: 空格键
# 
# 多媒体键
# KEYCODE_MEDIA_PLAY: 多媒体键 播放
# KEYCODE_MEDIA_STOP: 多媒体键 停止
# KEYCODE_MEDIA_PAUSE: 多媒体键 暂停
# KEYCODE_MEDIA_PLAY_PAUSE: 多媒体键 播放/暂停
# KEYCODE_MEDIA_FAST_FORWARD: 多媒体键 快进
# KEYCODE_MEDIA_REWIND: 多媒体键 快退
# KEYCODE_MEDIA_NEXT: 多媒体键 下一首
# KEYCODE_MEDIA_PREVIOUS: 多媒体键 上一首
# KEYCODE_MEDIA_CLOSE: 多媒体键 关闭
# KEYCODE_MEDIA_EJECT: 多媒体键 弹出
# KEYCODE_MEDIA_RECORD: 多媒体键 录音
# 

# Check for android device
device=`adb devices | grep "device$" | awk '{print $1}'`
if [ -z ${device} ]; then
	echo "[ERR] no device found"
	exit 2
fi

times=1
if [ $# -ge 2 ]; then
	if grep '^[[:digit:]]*$' <<< "$2" > /dev/null;then
		times=$2
	else
		echo "[ERR] execute time [$2] setting error, ingore it"
	fi
fi

cmd=""
if [ $# -ge 1  ]; then
	case $1 in
		play)
			echo "[INFO] Play Music"
			cmd="KEYCODE_MEDIA_PLAY"
			;;
		pause)
			echo "[INFO] Pause Music"
			cmd="KEYCODE_MEDIA_PAUSE"
			;;
		stop)
			echo "[INFO] Stop Music"
			cmd="KEYCODE_MEDIA_STOP"
			;;
		up)
			echo "[INFO] Volume up"
			cmd="KEYCODE_VOLUME_UP"
			;;
		down)
			echo "[INFO] Volume down"
			cmd="KEYCODE_VOLUME_DOWN"
			;;
		next)
			echo "[INFO] Next music"
			cmd="KEYCODE_MEDIA_NEXT"
			;;
		previous)
			echo "[INFO] Previous music"
			cmd="KEYCODE_MEDIA_PREVIOUS"
			;;
		*)
			echo "[ERR] Unknow command: $1"
			exit 1
			;;
	esac
else
	echo "[ERR] No input argument, reference:"
	echo -e "\t$0 + arg + [times]"
fi

if [ ! -z $cmd ]; then
	echo "[INFO] Going to execute cmd: $cmd"
	i=0
	while [ $i -lt ${times} ]; do
		CMD_EXEC_RESULT=`adb -s ${device} shell input keyevent $cmd`
		if [ $? -ne 0 ]; then
			echo "[ERR] adb cmd fail"
			exit 3
		fi
		i=$((i+1))
		if [ ${times} -gt 1 ]; then
			echo -n ".."
		fi
	done
	if [ ${times} -gt 1 ]; then
		echo ""
	fi
	echo "[INFO] ok"
fi
