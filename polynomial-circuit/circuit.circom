/**
 * @author Ashutosh Kushwaha
 * @email ashutoshkushwaha81@gmail.com
 * @create date 2021-04-20 11:40:05
 * @modify date 2021-04-20 11:40:05
 */

/*
Creating a circuit with equation: x**2 + 3*x = c.
In this case c is public parameter, while x is the private paramater.
*/


template Polynomial_circuit(){
    signal private input x;
    signal output c;
    c <== x*x + 3*x;
}

component main= Polynomial_circuit();
