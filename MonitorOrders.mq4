//+------------------------------------------------------------------+
//|                                                MonitorOrders.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


int CheckOpenOrders(){
   //We need to scan all the open and pending orders to see if there is there is any
   //OrdersTotal return the total number of market and pending orders
   //What we do is scan all orders and check if they are of the same symbol of the one where the EA is running
   int counter = 0;
   for( int i = 0 ; i < OrdersTotal() ; i++ ) {
      //We select the order of index i selecting by position and from the pool of market/pending trades
      if(OrderSelect( i, SELECT_BY_POS, MODE_TRADES )){
         counter++;
      }
   }
   //If the loop finishes it mean there were no open orders for that pair
   return counter;
}

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   Print("Number of currently opened orders ",CheckOpenOrders());
  }
//+------------------------------------------------------------------+
