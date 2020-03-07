#property strict

#include "WriteToFile.mqh"
#include "Types.mqh"
#include "Calculations.mqh"
#include "WriteOrderMetadata.mqh"

double currentBalance = 0;

void getHistory() {
  int numberOfCompletedOrders = OrdersHistoryTotal();
  
  Order completedOrders[];
  ArrayResize(completedOrders, numberOfCompletedOrders);

  for(int i=0; i < numberOfCompletedOrders; i++) {
    if(OrderSelect(i, SELECT_BY_POS, MODE_HISTORY) == false) {
    Print("Access to history failed with error (", GetLastError(), ")");
    break;
    }

    writeOrderMetadata(currentBalance, completedOrders[i]);
  }

  writeToCSVFileArray("history.csv", numberOfCompletedOrders, completedOrders);
}

void getCurrentOrders() {
  int numberOfActiveOrders = OrdersTotal();

  Order activeOrders[];
  ArrayResize(activeOrders, numberOfActiveOrders);

  for(int i=0; i < numberOfActiveOrders; i++) {
    if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == false) {
      Print("Access to actual orders failed with error (", GetLastError(), ")");
      break;
    }
    writeOrderMetadata(currentBalance, activeOrders[i]);
  }

  writeToCSVFileArray("current.csv", numberOfActiveOrders, activeOrders);
}