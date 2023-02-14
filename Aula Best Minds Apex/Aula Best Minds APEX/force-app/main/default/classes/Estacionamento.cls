public class Estacionamento {
    List<Carro> lstCarros = new List<Carro>();
    public void adicionarCarros(Integer codigo, String marca, String cor, Integer anoFabricacao){
        Carro objCarro = new Carro();
        objCarro.Marca = marca;
        objCarro.Cor = cor;
        objCarro.anoFabricacao = anoFabricacao;
        objCarro.Codigo = codigo;
        lstCarros.add(objCarro);        
    }
    public void listarCarros(){
        for (Carro objCarro : lstCarros) {
            System.debug('Código: ' + String.valueOf(objCarro.Codigo) + ' Marca: ' + objCarro.Marca);
        }
    }
    public List<Carro> tipoRetorno(){
       return lstCarros;    
    }
    public void removerCarro(Integer codigo){
        List<Carro> lstAuxiliar = new List<Carro>();
        lstAuxiliar.addAll(lstCarros);
        Integer indice = 0;
        // for(Integer i = 0; i < lstCarros.size(); i++){
        //     if(lstCarros[i].Codigo == codigo){
        //         lstAuxiliar.remove(i);
        //     }
        // }
        // for(Integer i = 0; i < lstCarros.size(); i++){
        //     if(lstCarros[i].Codigo != codigo){
        //         lstAuxiliar.add(lstCarros[i]);
        //     }
        // }
        // for (Carro objCarro : lstCarros) {
        //     if(objCarro.Codigo != codigo){
        //         lstAuxiliar.add(objCarro);
        //     }
        //     indice++;
        // }
        for (Carro objCarro : lstCarros) {
            if(objCarro.Codigo == codigo){
                lstAuxiliar.remove(indice);
            }
            indice++;
        }
        lstCarros = lstAuxiliar;
    }
}