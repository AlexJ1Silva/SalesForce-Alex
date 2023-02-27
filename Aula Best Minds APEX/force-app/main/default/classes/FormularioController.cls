public with sharing class FormularioController{
    @AuraEnabled
    public static ViaCepTO getEnderecoByCep(String cep){
        String endpoint = 'https://viacep.com.br/ws/' + cep + '/json/';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');

        // Specify the required user name and password to access the endpoint
        // As well as the header and header information
        /*
         String username = 'myname';
         String password = 'mypwd'; */

        /* Blob headerValue = Blob.valueOf(username + ':' + password);
         String authorizationHeader = 'Basic ' + */
        /* EncodingUtil.base64Encode(headerValue);
         req.setHeader('Authorization', authorizationHeader); */

        // Create a new http object to send the request object
        // A response object is generated as a result of the request

        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        return (ViaCepTO)JSON.deserialize(res.getBody(), FormularioController.ViaCepTO.class);
    }

    public class ViaCepTO{
       
        @AuraEnabled public String cep{ get; set; }

        @AuraEnabled public String logradouro{ get; set; }

        @AuraEnabled public String complemento{ get; set; }

        @AuraEnabled public String bairro{ get; set; }

        @AuraEnabled public String localidade{ get; set; }

        @AuraEnabled public String uf{ get; set; }

        @AuraEnabled public String ibge{ get; set; }

        @AuraEnabled public String gia{ get; set; }

        @AuraEnabled public String ddd{ get; set; }

        @AuraEnabled public String siafi{ get; set; }

    }

}