public class Pessoa{
    public List<Pessoa> lstPessoa = new List<Pessoa>();
    public String nome;
    public Date dataNascimento;
    public void adicionarPessoa(String nome, Date dataNascimento){
        Pessoa p = new Pessoa();
        p.nome = nome;
        p.dataNascimento = dataNascimento;
        lstPessoa.add(p);
    }

    public Pessoa menorIdade(){

        Pessoa pNova = new Pessoa();
        for (Pessoa p : this.lstPessoa){
            if (pNova.dataNascimento < p.dataNascimento || pNova.dataNascimento == null){
                pNova = p;
            }

        }
        return pNova;
    }

    public Pessoa maiorIdade(){

        Pessoa pMaior = new Pessoa();
        for (Pessoa p : this.lstPessoa){
            if (pMaior.dataNascimento > p.dataNascimento || pMaior.dataNascimento == null){
                pMaior = p;
            }

        }
        return pMaior;
    }

}