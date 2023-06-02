source=$1
target=$2

if [[ $# -eq 0  ]] ; then
    echo 'ERROR: No Arguments Provided'
    exit 0
fi

media_dir=/mnt_media
source_file=$media_dir/$1
fragemented_file=$media_dir/fragemented.mp4
target_file=$media_dir/enc_$1
output_dir=$media_dir/$2

# KID: 32-character hex string
KID=A16E402B9056E371F36D348AA62BB749
# KEY: either a 32-character hex string or the character # followed by a base64-encoded key seed.
KEY=87237D20A19F58A740C05684E699B4AA


echo "Trying to encrypt file $1"
echo "Fragmenting file..."
mp4fragment $source_file $fragemented_file

echo "Encrypting file..."
mp4encrypt --method MPEG-CENC --key 1:$KEY:random --property 1:KID:$KID --key 2:$KEY:random --property 2:KID:$KID --global-option mpeg-cenc.eme-pssh:true $fragemented_file $target_file

echo "Splitting and encrypting file..."
rm -rf $output_dir
mp4dash -o $output_dir $target_file

echo "Cleaning up temp files"
rm $fragemented_file
rm $target_file

echo "------- Files are ready in folder : $output_dir -------"

