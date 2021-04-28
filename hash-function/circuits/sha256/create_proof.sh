#! /bin/bash

# /**
#  * @author Ashutosh Kushwaha
#  * @email ashutoshkushwaha81@gmail.com
#  * @create date 2021-04-18 11:00:20
#  * @modify date 2021-04-18 11:00:20
#  * @desc [description]
#  */
while test $# -gt 0; do
    case "$1" in
        -h|--help)
            echo "$package - attempt to capture frames"
            echo " "
            echo "$package [options] application [arguments]"
            echo " "
            echo "options:"
            echo "-h, --help                show brief help"
            echo "-i, --input               specify the name of input file without .json extension"
            exit 0
            ;;
        -i| --input)
            shift
            if test $# -gt 0; then
                export input_name=$1
            else
                echo "no filename is specified"
                exit 1
            fi
            shift
            ;;
        *)
            break
        ;;
    esac
done;

witness=${input_name:-'input'}_witness.wtns
# echo "snarkjs groth16 prove circuit_final.zkey ${witness} proof.json public.json"
snarkjs groth16 prove circuit_final.zkey $witness proof.json public.json
if [[ $? == 0 ]];
then
    echo "🎊 Proof is created successfully"
    echo "------------------------------------------------------------------------------------------------------------------------"
    echo "💻 Proof: "
    cat proof.json
    echo "------------------------------------------------------------------------------------------------------------------------"
    echo "📢 Public: "
    cat public.json
    echo "------------------------------------------------------------------------------------------------------------------------"
else
    echo "💔 Proof is not created"
fi