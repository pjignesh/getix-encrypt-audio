source=$1
target=$2

if [[ $# -eq 1 ]] ; then
    echo 'ERROR: Source file name missing'
    exit 0
fi

if [[ $# -eq 2 ]] ; then
    echo 'ERROR: Destination directory name missing'
    exit 0
fi

media_dir=/mnt_media
source_file=$media_dir/$1
fragemented_file=$media_dir/fragemented.mp4
target_file=$media_dir/enc_$1

output_dir=$2

echo "Trying to encrypt file $1"
echo "Fragmenting file..."
docker run -v $(pwd)/source_media:/mnt_media -it alfg/bento4 mp4fragment $source_file $fragemented_file

echo "Encrypting file..."
docker run -v $(pwd)/source_media:/mnt_media -it alfg/bento4 mp4encrypt --method MPEG-CENC --key 1:87237D20A19F58A740C05684E699B4AA:random --property 1:KID:A16E402B9056E371F36D348AA62BB749 --key 2:87237D20A19F58A740C05684E699B4AA:random --property 2:KID:A16E402B9056E371F36D348AA62BB749 --global-option mpeg-cenc.eme-pssh:true $fragemented_file $target_file

echo "Splitting file..."
docker run -v $(pwd)/source_media:/mnt_media -it alfg/bento4 python mp4dash -o $output_dir $target_file
