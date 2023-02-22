public abstract class ContaBancaria {


        public Double limite;
        public Double saldo;
       
       

        public Boolean sacar(Double saque){
             Double valortotal = saldo + limite;
             Boolean sucesso = false;

             if (saque <= valortotal){
                if(saque > saldo){
                    saque = saque - saldo;
                    saldo = 0;
                    limite = limite - saque;
                }else {
                    saldo = saldo - saque;
                }
                sucesso = true;
             }else {
                sucesso = false;
             }
             return sucesso;
        }
        public Double saldoAtual(){
            return saldo + limite;
        }
}