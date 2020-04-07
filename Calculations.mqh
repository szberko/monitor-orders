#property strict

#include "Utils.mqh"

double calcRValue(double orderOpenPrice, double stopLoss){
  return MathAbs(orderOpenPrice - stopLoss);
}

double calcReachedR(double orderOpenPrice, double orderClosePrice, double rValue, int orderType) {
  if(isBuyOrder(orderType) && rValue > 0) {
    return (orderClosePrice - orderOpenPrice) / rValue;
  }

  if(isSellOrder(orderType) && rValue > 0){
    return (orderOpenPrice - orderClosePrice) / rValue;
  }

  return INVALID_R_VALUE;
}

//+------------------------------------------------------------------+
//| Calculate time periods                                           |
//+------------------------------------------------------------------+
PeriodOfTime calcPeriod(string orderSymbol, datetime orderOpenTime, datetime orderCloseTime, double orderOpenPrice, int orderType, double orderRValue) {
  PeriodOfTime periodOfTime;
  periodOfTime.allInSeconds = orderCloseTime - orderOpenTime;

  TimeAndRStatistics statisticsAboveOpenPrice = calcSecondsAboveOpenPrice(orderSymbol, orderOpenTime, orderCloseTime, orderOpenPrice, orderRValue);
  TimeAndRStatistics statisticsBelowOpenPrice = calcSecondsBelowOpenPrice(orderSymbol, orderOpenTime, orderCloseTime, orderOpenPrice, orderRValue);

  

  // BUY
  if(isBuyOrder(orderType)){
    periodOfTime.maxPositivePrice = statisticsAboveOpenPrice.price;
    periodOfTime.maxNegativePrice = statisticsBelowOpenPrice.price;

    periodOfTime.positiveInSeconds = statisticsAboveOpenPrice.seconds;
    periodOfTime.negativeInSeconds = statisticsBelowOpenPrice.seconds;

    periodOfTime.maxPositiveR = statisticsAboveOpenPrice.r;
    periodOfTime.maxNegativeR = statisticsBelowOpenPrice.r;
  }

  // SELL
  if(isSellOrder(orderType)){
    periodOfTime.maxPositivePrice = statisticsBelowOpenPrice.price;
    periodOfTime.maxNegativePrice = statisticsAboveOpenPrice.price;

    periodOfTime.positiveInSeconds = statisticsBelowOpenPrice.seconds;
    periodOfTime.negativeInSeconds = statisticsAboveOpenPrice.seconds;

    periodOfTime.maxPositiveR = statisticsBelowOpenPrice.r;
    periodOfTime.maxNegativeR = statisticsAboveOpenPrice.r;
  }

  if (periodOfTime.allInSeconds > 0) {
    periodOfTime.positiveInPercent = ((double) periodOfTime.positiveInSeconds / (double) periodOfTime.allInSeconds) * 100;
    periodOfTime.negativeInPercent = ((double) periodOfTime.negativeInSeconds / (double) periodOfTime.allInSeconds) * 100;
  } else {
    periodOfTime.positiveInPercent = INVALID_VALUE;
    periodOfTime.negativeInPercent = INVALID_VALUE;
  }

  return periodOfTime;
}

int calcSeconds(datetime orderOpenTime, datetime orderCloseTime, double orderOpenPrice) {
  return orderCloseTime - orderOpenTime;
}

TimeAndRStatistics calcSecondsAboveOpenPrice(string orderSymbol, datetime orderOpenTime, datetime orderCloseTime, double orderOpenPrice, double orderRValue) {
  datetime positionInTime = orderOpenTime;
  int seconds = 0;
  double highestPrice = orderOpenPrice;
  
  while(positionInTime < orderCloseTime){
    int  iWhenM1 = iBarShift(orderSymbol, PERIOD_M1, positionInTime, true);
    // Calculate just in case if the bar has match
    if(iWhenM1 != -1) {
      double candleClosePrice = iClose(orderSymbol, PERIOD_M1, iWhenM1);
      double candleHighestPrice = iHigh(orderSymbol, PERIOD_M1, iWhenM1);
      // amount of seconds above open price area
      if(candleClosePrice > orderOpenPrice) {
        seconds++;
      }

      if(candleHighestPrice > highestPrice){
        highestPrice = candleHighestPrice;
      }
    }
    positionInTime++;
  }
  
  TimeAndRStatistics timeAndRStatistics;
  timeAndRStatistics.seconds = seconds;
  timeAndRStatistics.price = highestPrice;
  if (orderRValue > 0) {
    timeAndRStatistics.r = (highestPrice - orderOpenPrice) / orderRValue;
  } else {
    timeAndRStatistics.r = INVALID_VALUE;
  }
  return timeAndRStatistics;
}

TimeAndRStatistics calcSecondsBelowOpenPrice(string orderSymbol, datetime orderOpenTime, datetime orderCloseTime, double orderOpenPrice, double orderRValue) {
  datetime positionInTime = orderOpenTime;

  int seconds = 0;
  double lowestPrice = orderOpenPrice;

  while(positionInTime < orderCloseTime){
    int  iWhenM1 = iBarShift(orderSymbol, PERIOD_M1, positionInTime, true);
    // Calculate just in case if the bar has match
    if(iWhenM1 != -1) {
      double candleClosePrice = iClose(orderSymbol, PERIOD_M1, iWhenM1);
      double candleLowestPrice = iLow(orderSymbol, PERIOD_M1, iWhenM1);
      // amount of seconds below open price area
      if(candleClosePrice <= orderOpenPrice) {
        seconds++;
      }
      
      if(candleLowestPrice < lowestPrice) {
        lowestPrice = candleLowestPrice;
      }
    }
    positionInTime++;
  }

  TimeAndRStatistics timeAndRStatistics;
  timeAndRStatistics.seconds = seconds;
  timeAndRStatistics.price = lowestPrice;
  if (orderRValue > 0) {
    timeAndRStatistics.r = (orderOpenPrice - lowestPrice) / orderRValue;
  } else {
    timeAndRStatistics.r = INVALID_VALUE;
  }
  return timeAndRStatistics;
}

//+------------------------------------------------------------------+
//| Calculate lowest and highest value                               |
//| NOT USED                                                         |
//+------------------------------------------------------------------+
void calcLowAndHigh(datetime start, datetime end)
  {
    string   s           = OrderSymbol();
    int      p           = Period();
    datetime t1          = start;
    datetime t2          = end;
    int      t1_shift    = iBarShift(s,p,t1);
    int      t2_shift    = iBarShift(s,p,t2);
    int      bar_count   = t1_shift-t2_shift;
    int      high_shift  = iHighest(s,p,MODE_HIGH,bar_count,t2_shift);
    int      low_shift   = iLowest(s,p,MODE_LOW,bar_count,t2_shift);
    double   high        = iHigh(s,p,high_shift);
    double   low         = iLow(s,p,low_shift);
    Print(t1," -> ",t2,":: High = ",high," Low = ",low);
  }

double calcLow(string symbol, datetime start, datetime end) {
  string   s           = symbol;
  int      p           = PERIOD_M1;
  datetime t1          = start;
  datetime t2          = end;
  int      t1_shift    = iBarShift(s,p,t1);
  int      t2_shift    = iBarShift(s,p,t2);
  int      bar_count   = t1_shift-t2_shift;
  int      low_shift   = iLowest(s,p,MODE_LOW,bar_count,t2_shift);
  double   low         = iLow(s,p,low_shift);
  return low;
}

double calcHigh(string symbol, datetime start, datetime end) {
  string   s           = symbol;
  int      p           = PERIOD_M1;
  datetime t1          = start;
  datetime t2          = end;
  int      t1_shift    = iBarShift(s,p,t1);
  int      t2_shift    = iBarShift(s,p,t2);
  int      bar_count   = t1_shift-t2_shift;
  int      high_shift  = iHighest(s,p,MODE_HIGH,bar_count,t2_shift);
  double   high        = iHigh(s,p,high_shift);
  return high;
}
