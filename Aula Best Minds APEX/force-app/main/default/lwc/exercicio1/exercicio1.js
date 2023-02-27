import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Exercicio1 extends LightningElement {
    @track nome = '';
    @track idade = '';
    @track email = '';
    @track cpf = '';
    @track cnpf = '';
    @track cep = '';
    @track cidade = '';
    @track uf = '';
    @track endereco = '';
    @track telefone = '';
    @track resp = '';
    @track resp2 = '';
    @track bcpf;
    @track bcnpj;
    @track labelData;
    @track mostraLimpar = true;


    //função mascara de telefone.
    handlePhoneInputMask(event) {
        let idComponente = event.target.dataset.id;

        if (idComponente == 'telefone') {
            const x = event.target.value
                .replace(/\D+/g, '')
                .match(/(\d{0,2})(\d{0,5})(\d{0,4})/);
            event.target.value =
                !x[2] ? x[1] : `(${x[1]}) ${x[2]}` + (x[3] ? `-${x[3]}` : ``);
            this.telefone = event.target.value;
        }


    }
    
    //função mascara de cpf
    handleCpfInputMask(event) {

        let idComponente = event.target.dataset.id;


        if (idComponente == 'cpf') {
            const x = event.target.value
                .replace(/\D+/g, '')
                .match(/(\d{0,3})(\d{0,3})(\d{0,3})(\d{0,2})/);
            event.target.value =
                `${x[1]}` + (x[2] ? `.${x[2]}` : ``) + (x[3] ? `.${x[3]}` : ``) + (x[4] ? `-${x[4]}` : ``);
            this.cpf = event.target.value;
        }

    }

    //função mascara de cnpj
    handleCnpjInputMask(event) {

        let idComponente = event.target.dataset.id;


        if (idComponente == 'cnpj') {
            const x = event.target.value
                .replace(/\D+/g, '')
                .match(/(\d{0,2})(\d{0,3})(\d{0,3})(\d{0,4})(\d{0,2})/);
            event.target.value =
                `${x[1]}` + (x[2] ? `.${x[2]}` : ``) + (x[3] ? `.${x[3]}` : ``) + (x[4] ? `/${x[4]}` : ``) + (x[5] ? `-${x[5]}` : ``);
            this.cnpj = event.target.value;
        }

    }

    //função principal 
    handleInput(event) {


        let idComponente = event.target.dataset.id;


        if (idComponente == 'nome') {
            this.nome = event.target.value;
        }
        if (idComponente == 'idade') {
            this.idade = event.target.value;
        }
        if (idComponente == 'email') {
            this.email = event.target.value;
        }
        if (idComponente == 'bcpf') {
            this.bcpf = event.target.checked;
            this.labelData = 'Data de Nascimento';
            if(this.bcpf == false){
               
                this.handleLimpar(this.limpar());
            }

        }
        if (idComponente == 'bcnpj') {
            this.bcnpj = event.target.checked;
            this.labelData = 'Data de Criação';
            if(this.bcnpj == false){
                
                this.handleLimpar(this.limpar());
            }

        }

        if (idComponente == 'cep') {
            this.cep = event.target.value;
        }

        if (idComponente == 'cidade') {
            this.cidade = event.target.value;
        }

        if (idComponente == 'uf') {
            this.uf = event.target.value;
        }

        if (idComponente == 'endereco') {
            this.endereco = event.target.value;
        }
        this.handleLimpar();

    }

    //função para exibir o botão de limpar
    handleLimpar() {
    
            if(this.bcpf == false && this.bcnpj == false)
           /*  this.idade == '' &&
            this.cpf =='' &&
            this.cep == '' &&
            this.email == '' &&
            this.cidade == '' &&
            this.uf == '' &&
            this.endereco == '' &&
            this.telefone == '') */{
                this.mostraLimpar = true;
                return
            }else{
                this.mostraLimpar = false;
            }

           /*  if(this.bcnpj && 
            this.nome == '' &&
            this.idade == '' &&
            this.email == '' &&
            this.cnpj =='' &&
            this.cep == '' &&
            this.cidade == '' &&
            this.uf == '' &&
            this.endereco == '' &&
            this.telefone == ''){
                this.mostraLimpar = true;

            }else{
                this.mostraLimpar = false;
            }
         */
        
    }

    //função de limpar os campos para o botão limpar
    limpar() {
        //console.log('##### entrei no limpar');
       
            this.nome = '';
            this.idade = '';
            this.cpf = '';
            this.cnpj = '';
            this.email = '';
            this.cep = '';
            this.cidade = '';
            this.uf = '';
            this.labelData = '';
            this.endereco = '';
            this.telefone = '';
            this.bcnpj = false;
            this.bcpf = false;
            this.resp = false;
            this.resp2 = false;
            this.handleLimpar();

    }

    //função para exibir alertas salesforce
    showToast(titulo, msg, variant) {
        const event = new ShowToastEvent({
            title: titulo,
            message: msg,  
            variant: variant,
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
    //função botão cadastrar
    handleClick(event) {
        if (this.bcpf) {
            this.resp = true;
            this.resp2 = false;
        }
        if (this.bcnpj) {
            this.resp2 = true;
            this.resp = false;

        }
    }

    
}