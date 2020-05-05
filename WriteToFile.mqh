#property strict

#include "Types.mqh"

//+------------------------------------------------------------------+
//| Write to file algorithm                                          |
//+------------------------------------------------------------------+
int writeToCSVFileArray(string fileName, int totalNoOfOrders, Order &orders[]) {
  int handle=FileOpen(fileName, FILE_WRITE | FILE_CSV, ',');
  if (handle != INVALID_HANDLE){
    Print("write to file");
    FileWrite(handle, 
                "ticketNo", 
                "instrument", 
                "openTime", 
                "closeTime", 
                "low", 
                "high", 
                "orderType",
                "orderOpenPrice",
                "orderStopLoss",
                "orderTakeProfit",
                "orderClosePrice",
                "orderLots",
                "valueOfR",
                "reachedR",
                "orderPeriodInSeconds",
                "orderMaxPositivePrice",
                "orderMaxPositiveR",
                "orderPositivePeriodInPercent",
                "orderPositivePeriodInSeconds",
                "orderMaxNegativePrice",
                "orderMaxNegativeR",
                "orderNegativePeriodInPercent",
                "orderNegativePeriodInSeconds",
                "netProfit",
                "balance",
                "riskMoney",
                "riskPercentage");

    for(int i=0; i < totalNoOfOrders; i++) {
      Order order = orders[i];
      FileWrite(handle, 
                order.ticketNo, 
                order.symbol, 
                order.openTime, 
                order.closeTime, 
                order.low, 
                order.high, 
                order.type,
                order.openPrice,
                order.stopLoss,
                order.takeProfit,
                order.closePrice,
                order.lot,
                order.rValue,
                order.reachedR,
                order.periodOfTime.allInSeconds,
                order.periodOfTime.maxPositivePrice,
                order.periodOfTime.maxPositiveR,
                order.periodOfTime.positiveInPercent,
                order.periodOfTime.positiveInSeconds,
                order.periodOfTime.maxNegativePrice,
                order.periodOfTime.maxNegativeR,
                order.periodOfTime.negativeInPercent,
                order.periodOfTime.negativeInSeconds,
                order.netProfit,
                order.balance,
                order.riskMoney,
                order.riskPercentage
                );
    }
  
    FileClose(handle);
  } else {
    Alert("Failed to open data file. Please check if you have write priviledge!");
  }
  return(0);
}