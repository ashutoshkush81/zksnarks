#! /bin/bash
# /**
#  * @author Ashutosh Kushwaha
#  * @email ashutoshkushwaha81@gmail.com
#  * @create date 2021-04-18 07:27:48
#  * @modify date 2021-04-18 07:27:48
#  * @desc [This script will be used for the generate witness of the circuit]
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
            echo "-c, --circuit             specify the name of circuit without .circom extension"
            echo "-i --input                specify the name of the input file without .json extension"
            exit 0
            ;;
        -c| --circuit)
            shift
            if test $# -gt 0; then
                export circuit_name=$1
            else
                echo "no filename is specified"
                exit 1
            fi
            shift
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

# Check if arguments are provided or not. if not then assigned default value
circuit=${circuit_name:-'circuit'}.wasm
input=${input_name:-'input'}.json
witness=${input_name:-'input'}_witness.wtns
echo "🌠 Generating witness for your given circuit and input..."
snarkjs wtns calculate $circuit $input $witness
echo "💪 Exporting your witness file into the json format..."
snarkjs wtns export json $witness
echo "✔ Witness generated..."
# cat witness.json
