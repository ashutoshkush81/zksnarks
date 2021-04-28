#! /bin/bash
# /**
#  * @author Ashutosh Kushwaha
#  * @email ashutoshkushwaha81@gmail.com
#  * @create date 2021-04-17 23:02:43
#  * @modify date 2021-04-17 23:02:43
#  * @desc [This script is used for the compiling the circom circuit]
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
        *)
            break
        ;;
    esac
done;



circuit=${circuit_name:-'circuit'}
echo "✔ Compiling the circuit ..."
circom $circuit.circom --r1cs --wasm --sym -v
if [[ $? == 0 ]];
then
    echo '✔ Circuit Compilation successful'
    echo 'ℹ️ Info about the circuit ...'
    snarkjs r1cs info $circuit.r1cs
    echo '✨ Constraints for circuit ...'
    snarkjs r1cs print $circuit.r1cs $circuit.sym
    echo '✨ Exporting r1cs file into json'
    snarkjs r1cs export json $circuit.r1cs $circuit.r1cs.json

else    
    echo '❌ Circit Compilation failed'
fi
