public abstract class Automovel{
    public Integer anoFabricacao {get; set;}
    public String marca {get; set;}
    public String placa {get; set;}
    public String modelo {get; set;}
    public String cor {get; set;}
    public Integer codigo {get; set;}

    public Integer obterIdadeUso(){
        return Datetime.now().year() - anoFabricacao;
    } 
}