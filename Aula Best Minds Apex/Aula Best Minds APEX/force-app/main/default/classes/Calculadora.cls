public with sharing class Calculadora {
    Decimal numero1;
    Decimal numero2;
    Decimal resultado;

    public  Calculadora(decimal numero1, decimal numero2) {
        this.numero1 = numero1;
        this.numero2 = numero2;     


    }

    public Decimal somar(){
        return this.numero1 + this.numero2;

    }

    public Decimal subtrair(){
        return this.numero1 - this.numero2;
    }

    public Decimal multiplicar(){
        return this.numero1 * this.numero2;
    }
    public Decimal dividir(){
        return this.numero1 / this.numero2;
    }
}