#!/bin/bash

decode_frame_dir=decode
VIDEO_FILE=VID_775.mp4

target_type="libx264 mpeg4 msmpeg4 flv libx265"
file_type=(mp4 avi avi flv mp4)

calc_time() {
	before=`date +%s`
	`$1`
	after=`date +%s`
	diff=$((after-before))
	echo $diff
}

if [ ! -d ${decode_frame_dir} ]; then
	mkdir -p ${decode_frame_dir}
fi

# time ffmpeg -i ${VIDEO_FILE} -c:v mjpeg  ${decode_frame_dir}/frame_%d.jpg
if [ ! -f ${decode_frame_dir}/result.yuv ]; then
	time_dec=`calc_time "ffmpeg -i ${VIDEO_FILE} -pix_fmt yuv420p ${decode_frame_dir}/result.yuv"`
fi

index=0
for type in $target_type; do
	echo $type ${file_type[$index]}

	output_filename=`echo "${decode_frame_dir}/result_${type}.${file_type[$index]}"`
	if [ -f ${output_filename} ]; then
		rm ${output_filename}
	fi

	time_info=`calc_time "ffmpeg  -pix_fmt yuv420p -video_size 1920x1080 -i ${decode_frame_dir}/result.yuv -c:v $type ${output_filename}"`

	size_info=`ls -lh ${output_filename} |awk '{print $5}'`	
	result_time=`echo "$result_time $time_info"`
	result_size=`echo "$result_size $size_info"`

	index=$((index+1))
done

echo "type: $target_type"
echo "time: $result_time"
echo "size: $result_size"

exit 0

time_mjpeg=`calc_time "ffmpeg  -pix_fmt yuv420p -video_size 1920x1080 -i ${decode_frame_dir}/result.yuv -c:v mjpeg ${decode_frame_dir}/result_mjpeg.mp4"`
time_flv=`calc_time "ffmpeg  -pix_fmt yuv420p -video_size 1920x1080 -i ${decode_frame_dir}/result.yuv -c:v flv ${decode_frame_dir}/result.flv"`

