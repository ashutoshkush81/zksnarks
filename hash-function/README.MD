# Hash Function
In the [sha256.circom](circuits/sha256/sha256.circom), I have illustrated a complex hash circuit using circom.
With the help of circom and snarkjs we can proof zksnarks.

## Install all the dependencies 
```
npm install
```

## Run above circuit and check if the proof known the solution of hash(message)
message --> Private input

hash --> Public input

0. Move to dir. sha256
```
cd circuits/sha256
```

1. Give permission to all the script file
```
chmod +x *.sh
```

2. Build the circuit with the help of circom
```
./build_circuit.sh -c sha256 
```

3.  Create setup phase using the help of power of tau and snarkjs
```
./setup.sh -c sha256
```

4. Generate Input file for the given message
```
node generate_input.js
```

5. Generate witness
```
./generate_witness.sh -c sha256 -i input
```

6. Create Proof
```
./create_proof.sh -i input
```

7. Verify Proof
```
./verify_proof.sh
```

If the final output is `[INFO]  snarkJS: OK!` then user knowns the solution of the above hash function.