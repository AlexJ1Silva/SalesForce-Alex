import { LightningElement, track } from 'lwc';

import  imagens from '@salesforce/resourceUrl/ComponenteIMC';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CalculadoraImc extends LightningElement {

    @track nome ='';
    @track peso ='';
    @track altura ='';
    @track resp ='';
    @track resultado ='';
    @track imc ='';
    @track img ='';
    @track mostraLimpar = true;

  handleInput(event){
        let idComponente = event.target.dataset.id;
        if(idComponente == 'nome'){
            this.nome = event.target.value;
        }
        if(idComponente == 'peso'){
            this.peso =  parseFloat(event.target.value);
        }
        
        if(idComponente == 'altura'){
            this.altura = parseFloat(event.target.value);
        }
        this.handleLimpar();
    }

    handleLimpar(){
        if(this.altura == '' && this.peso == ''  && this.nome == ''){
            this.mostraLimpar = true;
        }else{

            this.mostraLimpar = false;
            
        }
    }

    limpar(){
        //console.log('##### entrei no limpar');
        this.altura = '';
        this.peso = '';
        this.nome = '';
        this.resp = false;
        this.handleLimpar();

    }

    calcular(event){
        
        let imc =  this.peso / (this.altura * this.altura);

        if (this.nome === ''){
            this.showToast('[ERRO]', 'Você não colocou o seu nome!', 'error');
            return
        }
        if (this.peso === ''){
            this.showToast('[ERRO]', 'Você não colocou o seu peso!', 'error');
            return
        }
        if (this.altura === ''){
            this.showToast('[ERRO]', 'Você não colocou a sua altura!', 'error');
            
            return
        }
         else if (imc <16) {
            
            this.resultado = `${this.nome} Seu imc é ${imc.toFixed(2)} você está no grau magreza III.`
                this.img =('imagens/magreza3.png');    
                
        }else if (imc >16.1 && imc <16.9) {
            this.resultado  = `${this.nome} Seu imc é ${imc.toFixed(2)} você está no grau magreza II.`
                this.img = imagens+'/imagens/magreza2.png';
                
            
        }else if (imc >17 && imc <18.4) {
            this.resultado  = `${this.nome} Seu imc é ${imc.toFixed(2)} você está no grau magreza I.`
               this.img= imagens+'/imagens/magreza1.png';
               
        
        }else if (imc >18,5 && imc <24.9) {
            this.resultado  = `${this.nome} Seu imc é ${imc.toFixed(2)} você está com o peso normal.`
                this.img= imagens+'/imagens/imagens/normal.png';
               
        
        }else if (imc >25 && imc <29.9) {
            this.resultado  = `${this.nome} Seu imc é ${imc.toFixed(2)} você está com sobrepeso.`
               this.img= imagens+'/imagens/sobrepeso.png';
                
        
        }else if (imc >30 && imc <34.9) {
            this.resultado  = `${this.nome} Seu imc é ${imc.toFixed(2)} você está no grau obesidade I.`
               this.img = imagens+'/imagens/obesidade1.png';
               
        
        }else if (imc >35 && imc <39.9) {
            this.resultado  = `${this.nome} Seu imc é ${imc.toFixed(2)} você está no grau obesidade II.`
               this.img= imagens+'/imagens/obesidade2.png';
                
        
        }else if (imc >40) {
            this.resultado  = `${this.nome} Seu IMC é ${imc.toFixed(2)} você está no grau obesidade III.`
                this.img= imagens+'/imagens/obesidade3.png';
                
        }

        this.resp = true;
        
    }
    showToast(titulo, msg, variant) {
        const event = new ShowToastEvent({
            title: titulo,
            message: msg,  
            variant: variant,
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }

    
}