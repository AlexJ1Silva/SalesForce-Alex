public with sharing class Carro extends Automovel{
    
    public Integer anoFabricacao;

    public Carro(Integer anoFabricacao){
        this.anoFabricacao = anoFabricacao;
        
    }
    public Carro(){}
    
    public Integer anoVeiculo(){
        system.debug(this.anoFabricacao);
        return this.anoFabricacao;
    }  
}