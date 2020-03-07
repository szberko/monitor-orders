#property strict
//+------------------------------------------------------------------+
//| Calsses and structure definitions                                |
//+------------------------------------------------------------------+
const int INVALID_VALUE = -1;
const int INVALID_R_VALUE = -1000;

struct TimeAndRStatistics {
  public:
    int seconds;
    double r;
    double price;
};

struct PeriodOfTime {
  public:
    int allInSeconds;
    int positiveInSeconds;
    int negativeInSeconds;
    double positiveInPercent;
    double negativeInPercent;
    double maxPositiveR;
    double maxNegativeR;
    double maxPositivePrice;
    double maxNegativePrice;
};

class Order {
  public:
    int               ticketNo;
    string            symbol;
    datetime          openTime;
    datetime          closeTime;
    double            low;
    double            high;
    string            type;
    double            openPrice;
    double            stopLoss;
    double            takeProfit;
    double            closePrice;
    double            lot;
    double            rValue;
    double            reachedR;
    PeriodOfTime      periodOfTime;
    double            netProfit;
    double            balance;
    double            riskMoney;
    double            riskPercentage;

    void setMetadata(int c_ticketNo,
                      string c_symbol,
                      datetime c_openTime,
                      datetime c_closeTime,
                      double c_low,
                      double c_high,
                      string c_type,
                      double c_openPrice,
                      double c_stopLoss,
                      double c_takeProfit,
                      double c_closePrice,
                      double c_lot,
                      double c_rValue,
                      double c_reachedR,
                      PeriodOfTime& c_periodOfTime,
                      double c_netProfit,
                      double c_balance,
                      double c_riskMoney,
                      double c_riskPercentage) {
      ticketNo = c_ticketNo;
      symbol = c_symbol;
      openTime = c_openTime;
      closeTime = c_closeTime;
      low = c_low;
      high = c_high;
      type = c_type;
      openPrice = c_openPrice;
      stopLoss = c_stopLoss;
      takeProfit = c_takeProfit;
      closePrice = c_closePrice;
      lot = c_lot;
      rValue = c_rValue;
      reachedR = c_reachedR;
      periodOfTime = c_periodOfTime;
      netProfit = c_netProfit;
      balance = c_balance;
      riskMoney = c_riskMoney;
      riskPercentage = c_riskPercentage;
    }
};