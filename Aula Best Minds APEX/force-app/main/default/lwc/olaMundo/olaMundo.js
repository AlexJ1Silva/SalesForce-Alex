import { LightningElement, track }  from 'lwc';

import buscarMundoList from '@salesforce/apex/MundoController.buscarMundoList';

export default class OlaMundo extends LightningElement {

    @track nome = '';
    @track cor = '';
    @track qtdLuas = 0;
    @track possuiAgua = false;
    @track distanciaSol = 0;



   
   handleInput(event) {
    let idComponente = event.target.dataset.id;

    if (idComponente == 'nome') {
        this.nome = event.target.value;
    }
    if(idComponente == 'cor'){
        this.cor = event.target.value;
    }
    if(idComponente == 'distanciaSol'){
        this.distanciaSol = event.target.value;
    }
    if(idComponente == 'qtdLuas'){
        this.qtdLuas = event.target.value;
    }
    if(idComponente == 'possuiAgu'){
        this.possuiAgua = event.target.checked;
    }
    
   }

   getMundoList(){

    let m = {
        NomeMundo__c : this.nome, 
        Tamanho__c : this.tamanho, 
        Cor__c : this.cor, 
        PossuiAgua__c : this.possuiAgua, 
        DistanciaSol__c: this.distanciaSol
        
    }
    
    buscarMundoList({mundo:m}).then(r =>{

        
    });
   }
   handleClick(event){

    this.getMundoList();

   }
} 