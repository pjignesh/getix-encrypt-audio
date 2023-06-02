source_path=$1
target_path=$2
source_file_name=$3

 

if [[ $# -eq 0  ]] ; then
    echo 'ERROR: No Arguments Provided'
    exit 0
fi

 

media_dir=/mnt_media
output_dir=$media_dir/$target_path
echo "output_dir : $output_dir -------"
source_file=$media_dir/$1
echo "source_file : $source_file -------"
fragemented_file="${output_dir}fragemented.mp4"
echo "fragemented_file : $fragemented_file -------"
target_file=$media_dir/enc_$3
echo "target_file : $target_file -------"
converted_mp4_file="${output_dir}converted.mp4"
echo "converted_mp4_file : $converted_mp4_file -------"

 

# KID: 32-character hex string
#KID=A16E402B9056E371F36D348AA62BB749
KID=$4
# KEY: either a 32-character hex string or the character # followed by a base64-encoded key seed.
#KEY=87237D20A19F58A740C05684E699B4AA
KEY=$5
 

#Convert Mp3 to mp4
echo "ffmpeg -y -i $source_file -c:a aac -b:a 256k -f mp4 -movflags +empty_moov+separate_moof -frag_duration 10M $converted_mp4_file"
ffmpeg -y -i $source_file -c:a aac -b:a 256k -f mp4 -movflags +empty_moov+separate_moof -frag_duration 10M $converted_mp4_file

 

echo "Fragmenting file..."
echo "mp4fragment $converted_mp4_file $fragemented_file"
mp4fragment $converted_mp4_file $fragemented_file

 

echo "Encrypting file..."
echo "mp4encrypt --method MPEG-CENC --key 1:$KEY:random --property 1:KID:$KID --key 2:$KEY:random --property 2:KID:$KID --global-option mpeg-cenc.eme-pssh:true $fragemented_file $target_file"
mp4encrypt --method MPEG-CENC --key 1:$KEY:random --property 1:KID:$KID --key 2:$KEY:random --property 2:KID:$KID --global-option mpeg-cenc.eme-pssh:true $fragemented_file $target_file

 

echo "Splitting and encrypting file..."
rm -rf $output_dir
mp4dash -o $output_dir $target_file

 

# echo "Cleaning up temp files"
rm $converted_mp4_file
rm $fragemented_file
rm $target_file

 

#mv $output_dir /home/trellis/empereon/media/ai_evaluation/recordings/encrypted_audio_recordings/

 

echo "------- Files are ready in folder : $output_dir -------"
