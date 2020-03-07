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
                "Ticket No.", 
                "Instrument", 
                "Open Time", 
                "Close Time", 
                "Low", 
                "High", 
                "Order Type",
                "Order Open Price",
                "Order Stop Loss",
                "Order Take Profit",
                "Order Close Price",
                "Order Lots",
                "Value of R",
                "Reached R",
                "Order Period in Seconds",
                "Order Max Positive Price",
                "Order Max Positive R",
                "Order Positive Period in Percent",
                "Order Positive Period in Seconds",
                "Order Max Price",
                "Order Max Negative R",
                "Order Negative Period in Percent",
                "Order Negative Period in Seconds",
                "Net Profit",
                "Balance",
                "Risk Money",
                "Risk Percentage");

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