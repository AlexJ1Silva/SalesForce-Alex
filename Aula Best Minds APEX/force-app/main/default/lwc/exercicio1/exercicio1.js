import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getEnderecoByCep from '@salesforce/apex/FormularioController.getEnderecoByCep';
import nome_field from '@salesforce/schema/ListaFormulario__c.Nome__c';
import uf_field from '@salesforce/schema/ListaFormulario__c.UF__c';
import idade_field from '@salesforce/schema/ListaFormulario__c.DataNascimento__c';
import datacriacao_field from '@salesforce/schema/ListaFormulario__c.DataCriacao__c';
import bairro_field from '@salesforce/schema/ListaFormulario__c.Bairo__c';
import telefone_field from '@salesforce/schema/ListaFormulario__c.Telefone__c';
import endereco_field from '@salesforce/schema/ListaFormulario__c.Endereco__c';
import email_field from '@salesforce/schema/ListaFormulario__c.Email__c';
import cpf_field from '@salesforce/schema/ListaFormulario__c.CPF__c';
import cnpj_field from '@salesforce/schema/ListaFormulario__c.CNPJ__c';
import cep_field from '@salesforce/schema/ListaFormulario__c.CEP__c';
import cidade_field from '@salesforce/schema/ListaFormulario__c.Cidade__c';
import numero_field from '@salesforce/schema/ListaFormulario__c.Numero__c';
import complemento_field from '@salesforce/schema/ListaFormulario__c.Complemento__c';


import novoFormulario from '@salesforce/apex/FormularioListController.novoFormulario';

export default class Exercicio1 extends LightningElement {

    @track resp = '';
    @track resp2 = '';
    @track bcpf;
    @track bcnpj;
    @track labelData;
    @track mostraLimpar = true;
    @track novoFormularioId;
    @track novoFormulario = {

        nome : nome_field,
        idade : idade_field,
        email :  email_field,
        cpf : cpf_field,
        cnpj : cnpj_field,
        cep : cep_field,
        cidade : cidade_field,
        bairro : bairro_field,
        numero : numero_field,
        uf : uf_field,
        endereco : endereco_field, 
        telefone : telefone_field,
        complemento : complemento_field, 
}


    //função mascara de telefone.
    handlePhoneInputMask(event) {
        let idComponente = event.target.dataset.id;

        if (idComponente == 'telefone') {
            const x = event.target.value
                .replace(/\D+/g, '')
                .match(/(\d{0,2})(\d{0,5})(\d{0,4})/);
            event.target.value =
                !x[2] ? x[1] : `(${x[1]}) ${x[2]}` + (x[3] ? `-${x[3]}` : ``);
            this.novoFormulario.telefone = event.target.value;
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
            this.novoFormulario.cpf = event.target.value;
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
            this.novoFormulario.cnpj = event.target.value;
        }

    }

   
    //função chama via import methodo request de uma classe do apex e atribui os 
    //campos pegos no JSON(TO) aos campos do componente LWC.
    

    //função principal 
    handleInput(event) {


        let idComponente = event.target.dataset.id;


        if (idComponente == 'nome') {
            this.novoFormulario.nome = event.target.value;
        }
        if (idComponente == 'idade') {
            this.novoFormulario.idade = event.target.value;
        }
        if (idComponente == 'email') {
            this.novoFormulario.email = event.target.value;
        }
        if (idComponente == 'bcpf') {
            this.bcpf = event.target.checked;
            this.labelData = 'Data de Nascimento';
            if (this.bcpf == false) {

                this.handleLimpar(this.limpar());
            }

        }
        if (idComponente == 'bcnpj') {
            this.bcnpj = event.target.checked;
            this.labelData = 'Data de Criação';
            if (this.bcnpj == false) {

                this.handleLimpar(this.limpar());
            }

        }

        if (idComponente == 'cep') {
            this.novoFormulario.cep = event.target.value;
        }
        if (idComponente == 'numero') {
            this.novoFormulario.numero = event.target.value;
        }
        if (idComponente == 'bairo') {
            this.novoFormulario.bairro = event.target.value;
        }

        if (idComponente == 'cidade') {
            this.novoFormulario.cidade = event.target.value;
        }

        if (idComponente == 'uf') {
            this.novoFormulario.uf = event.target.value;
        }

        if (idComponente == 'endereco') {
            this.novoFormulario.endereco = event.target.value;
        }
        if (idComponente == 'complemento') {
            this.novoFormulario.complemento = event.target.value;
        }
        this.handleLimpar();

    }

    criarNovoFormulario(){
       
        let nf = {

            Nome__c : this.novoFormulario.nome,
            DataNascimento__c : this.novoFormulario.idade,
            //email_field : this.novoFormulario.email,
            CPF__c : this.novoFormulario.cpf,
            CNPJ__c : this.novoFormulario.cnpj,
            CEP__c : this.novoFormulario.cep, 
           Cidade__c : this.novoFormulario.cidade,
            Bairro__c : this.novoFormulario.bairro,
            Numero__c : this.novoFormulario.numero,
            UF__c : this.novoFormulario.uf,
            Endereco__c : this.novoFormulario.endereco,
            Telefone__c : this.novoFormulario.telefone,
            Complemento__c : this.novoFormulario.complemento,
            DataCriacao__c : this.novoFormulario.idade 

        };
        
        /* this.nf.Nome__c = this.novoFormulario.nome;
        this.nf.DataNascimento__c = this.novoFormulario.idade; 
        this.nf.Email__c = this.novoFormulario.email;
        this.nf.CPF__c =this.novoFormulario.cpf;
        this.nf.CNPJ__c = this.novoFormulario.cnpj;
        this.nf.CEP__c = this.novoFormulario.cep;
        this.nf.Cidade__c = this.novoFormulario.cidade;
        this.nf.Bairro__c = this.novoFormulario.bairro;
        this.nf.Numero__c = this.novoFormulario.numero;
        this.nf.UF__c = this.novoFormulario.uf;
        this.nf.Endereco__c = this.novoFormulario.endereco; 
        this.nf.Telefone__c = this.novoFormulario.telefone;
        this.nf.Complemento__c = this.novoFormulario.complemento;
 */

        console.log(nf);
        novoFormulario({listFormulario:nf}).then(r =>{

            
            
            const toastEvent = new ShowToastEvent(
                'Sucesso!',
                'Novo Formiulario criado com sucesso!!',
                'sucesso'
            );
        });
    }

    getEndereco() {
        if (this.novoFormulario.cep != '') {

            getEnderecoByCep({ cep: this.novoFormulario.cep }).then(r => {
                this.novoFormulario.cidade = r.localidade;
                this.novoFormulario.uf = r.uf;
                this.novoFormulario.endereco = r.logradouro;
                this.novoFormulario.bairro = r.bairro;
                console.log(r);

            });

        }
    }

    //função para exibir o botão de limpar
    handleLimpar() {

        if (this.bcpf == false && this.bcnpj == false)
           /*  this.idade == '' &&
            this.cpf =='' &&
            this.cep == '' &&
            this.email == '' &&
            this.cidade == '' &&
            this.uf == '' &&
            this.endereco == '' &&
            this.telefone == '') */ {
            this.mostraLimpar = true;
            return
        } else {
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

        this.novoFormulario.nome = '';
        this.novoFormulario.idade = '';
        this.novoFormulario.cpf = '';
        this.novoFormulario.cnpj = '';
        this.novoFormulario.email = '';
        this.novoFormulario.cep = '';
        this.novoFormulario.cidade = '';
        this.novoFormulario.complemento = '';
        this.novoFormulario.bairro = '';
        this.novoFormulario.numero = '';
        this.novoFormulario.uf = '';
        this.novoFormulario.labelData = '';
        this.novoFormulario.endereco = '';
        this.novoFormulario.telefone = '';
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
        this.criarNovoFormulario();
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