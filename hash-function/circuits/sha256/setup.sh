#! /bin/bash

# /**
#  * @author Ashutosh Kushwaha
#  * @email ashutoshkushwaha81@gmail.com
#  * @create date 2021-04-18 07:50:56
#  * @modify date 2021-04-18 07:50:56
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

echo "✨ Starting a new power of tau ceremony"
snarkjs powersoftau new bn128 16 pot12_0000.ptau -v
echo "------------------------------------------------------------------------------------------------------------------------"

echo "✨ Contribution to the ceremony"
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v
echo "------------------------------------------------------------------------------------------------------------------------"


echo "✨ Second contribution to the ceremony"
snarkjs powersoftau contribute pot12_0001.ptau pot12_0002.ptau --name="Second contribution" -v -e="some random text"
echo "------------------------------------------------------------------------------------------------------------------------"


echo "✨ Applying a random beacon"
snarkjs powersoftau beacon pot12_0002.ptau pot12_beacon.ptau 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon"
echo "------------------------------------------------------------------------------------------------------------------------"


echo "✨ Veriying the protocol so far"
snarkjs powersoftau verify pot12_beacon.ptau
echo "------------------------------------------------------------------------------------------------------------------------"


echo "〽️ Preparing for phase 2"
snarkjs powersoftau prepare phase2 pot12_beacon.ptau pot12_final.ptau -v
echo "------------------------------------------------------------------------------------------------------------------------"


echo "🧐 Verifying final ptau"
snarkjs powersoftau verify pot12_final.ptau
echo "------------------------------------------------------------------------------------------------------------------------"


echo "🚅 Generating the reference zkey without phase 2 contributions"
# Input required
snarkjs zkey new $circuit.r1cs pot12_final.ptau circuit_0000.zkey
echo "------------------------------------------------------------------------------------------------------------------------"


echo "🌟 Contributing to the phase 2 ceremony"
snarkjs zkey contribute circuit_0000.zkey circuit_0001.zkey --name="1st Contributor Name" -v
echo "------------------------------------------------------------------------------------------------------------------------"


echo "🌟 Provide a second contribution"
snarkjs zkey contribute circuit_0001.zkey circuit_0002.zkey --name="Second contribution Name" -v -e="Another random entropy"
echo "------------------------------------------------------------------------------------------------------------------------"


echo "⭐ Apply a random beacon"
snarkjs zkey beacon circuit_0002.zkey circuit_final.zkey 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon phase2"
echo "------------------------------------------------------------------------------------------------------------------------"

echo "🌟 Verify the final zkey"
# Input required
snarkjs zkey verify $circuit.r1cs pot12_final.ptau circuit_final.zkey
echo "------------------------------------------------------------------------------------------------------------------------"

echo "⏩ Exporting the verification key"
snarkjs zkey export verificationkey circuit_final.zkey verification_key.json
cat verification_key.json
echo "------------------------------------------------------------------------------------------------------------------------"


