public with sharing class OrderBO {
    
    // Valida se a UF do pedido é igual a UF da conta
    public static void validaEstado(List<Order> pedidos){

        Set<Id> setIdContas = new Set<Id>();

        for(Order pedido : pedidos){
            setIdContas.add(pedido.AccountId);
        }

        List<Account> contas = TestDAO.buscarContas(setIdContas);
        Map<Id, Account> mapAccount = new Map<Id, Account>();
        for(Account conta : contas){
            mapAccount.put(conta.Id, conta);
        }

        for(Order pedido : pedidos){
            Account conta = mapAccount.get(pedido.AccountId);
            if(conta.BillingState != pedido.BillingState){
                pedido.BillingState.addError('Uf do pedido diferente do cadastro da conta');
            }
        }
    }

    public static void somaTotalPedido(List<Order> pedidos, Map<Id, Order> mapOld){

        if(mapOld == null){
            mapOld = new Map<Id, Order>();
        }

        List<Order> pedidosProcessar = new List<Order>();
        Set<Id> idsPedido = new Set<Id>();
        for(Order pedido : pedidos){
            Order pedidoOld = mapOld.get(pedido.Id);

            // Valida se finalizou o pedido e se foi no momento de finalizar
            if(pedidoOld != null && pedido.Finalizado__c == true && pedido.Finalizado__c != pedidoOld.Finalizado__c){
                idsPedido.add(pedido.Id);
                pedidosProcessar.add(pedido);
            }
        }

        // Valido se tem itens para processar
        if(pedidosProcessar.isEmpty()){
            return;
        }

        // Buscando os itens do pedidos
        List<OrderItem> itensPedidoBase = OrderDAO.buscarPorPedidoId(idsPedido);
        Map<Id, List<OrderItem>> mapItens = new Map<Id, List<OrderItem>>();
        for(OrderItem item : itensPedidoBase){
            List<OrderItem> listItem = mapItens.get(item.OrderId);
            if(listItem == null){
                mapItens.put(item.OrderId, listItem = new List<OrderItem>());
            }
            listItem.add(item);
        }

        for(Order pedido : pedidos){
            List<OrderItem> itens = mapItens.get(pedido.Id);
            Decimal volumeTotal = 0;
            for(OrderItem item : itens){
                volumeTotal += item.Quantity;
            }

            pedido.VolumeTotal__c = volume;
        }
    }

    public static void somaTotalPedidoAggregate(List<Order> pedidos, Map<Id, Order> mapOld){

        if(mapOld == null){
            mapOld = new Map<Id, Order>();
        }

        List<Order> pedidosProcessar = new List<Order>();
        Set<Id> idsPedido = new Set<Id>();
        for(Order pedido : pedidos){
            Order pedidoOld = mapOld.get(pedido.Id);

            // Valida se finalizou o pedido e se foi no momento de finalizar
            if(pedidoOld != null && pedido.Finalizado__c == true && pedido.Finalizado__c != pedidoOld.Finalizado__c){
                idsPedido.add(pedido.Id);
                pedidosProcessar.add(pedido);
            }
        }

        // Valido se tem itens para processar
        if(pedidosProcessar.isEmpty()){
            return;
        }

        // Buscando os itens do pedidos
        List<AggregateResult> itensPedidoBase = OrderDAO.buscarPorPedidoId(idsPedido);
        // SELECT SUM(Quantity) soma, OrderId FROM OrderItem WHERE OrderId IN: ids GROUP BY OrderId
        Map<Id, AggregateResult> mapAggregateResult = new Map<Id, AggregateResult>();
        for(AggregateResult resultado : itensPedidoBase){
            mapAggregateResult.put((Id)resultado.get('OrderId'));
        }

        for(Order pedido : pedidos){
            AggregateResult resultado = mapAggregateResult.get(pedido.Id);
            pedido.VolumeTotal__c = Decimal.valueOf(resultado.get('soma'));
        }
    }
}
