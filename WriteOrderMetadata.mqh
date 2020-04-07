#property strict

#include "Utils.mqh"

void writeOrderMetadata(double &currentBalance, Order &order) {
  double rValue = calcRValue(OrderOpenPrice(), OrderStopLoss());
  
  double riskMoney = OrderLots() * MathAbs(OrderOpenPrice() - OrderStopLoss());
  // Risk Percentage should be calculated based on the balance closed by previous order.
  double riskPercentage = 0;
  if (currentBalance == 0) {
    riskPercentage = INVALID_VALUE;
  } else {
      riskPercentage = riskMoney / currentBalance;
  }

  // Current balance including the outcome of the current trade
  currentBalance = currentBalance + OrderSwap() + OrderCommission() + OrderProfit();

  order.setMetadata(
    OrderTicket(),
    OrderSymbol(),
    OrderOpenTime(),
    OrderCloseTime(),
    calcLow(OrderSymbol(), OrderOpenTime(), OrderCloseTime()),
    calcHigh(OrderSymbol(), OrderOpenTime(), OrderCloseTime()),
    getOrderTypeFrom(OrderType()),
    OrderOpenPrice(),
    OrderStopLoss(),
    OrderTakeProfit(),
    OrderClosePrice(),
    OrderLots(),
    rValue,
    calcReachedR(OrderOpenPrice(), OrderClosePrice(), rValue, OrderType()),
    calcPeriod(OrderSymbol(), OrderOpenTime(), OrderCloseTime(), OrderOpenPrice(), OrderType(), rValue),
    OrderProfit(),
    currentBalance,
    riskMoney,
    riskPercentage
  );
}