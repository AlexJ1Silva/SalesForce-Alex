import { LightningElement, track }  from 'lwc';

export default class OlaMundo extends LightningElement {
    @track titulo='Ola Mundo';
    @track ativo = true;
    @track mundoList = [{
        nome:'mundo AA'

    }];
}