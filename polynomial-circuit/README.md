# Polynomial Circuit
In the [circuit.circom](circuit.circom), I have illustrated a simple quadratic circuit using circom.
With the help of circom and snarkjs we can proof zksnarks.

## Run above circuit and check if the proof known the solution of x**2+3*x = c
x --> Private input

c --> Public input

1. Give permission to all the script file
```
chmod +x *.sh
```

2. Build the circuit with the help of circom
```
./build_circuit.sh -c circuit
```

3.  Create setup phase using the help of power of tau and snarkjs
```
./setup.sh -c circuit
```

4. Generate witness
```
./generate_witness.sh -c circuit -i input
```

5. Create Proof
```
./create_proof.sh -i input
```

6. Verify Proof
```
./verify_proof.sh
```

If the final output is `[INFO]  snarkJS: OK!` then user knowns the solution of the above equation for given c.