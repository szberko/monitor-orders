#property strict

bool isBuyOrder(int orderType) {
  return orderType == 0 || orderType == 2 || orderType == 4;
}

bool isSellOrder(int orderType) {
  return orderType == 1 || orderType == 3 || orderType == 5;
}

string getOrderTypeFrom(int orderType) {
  switch(orderType) {
    case(0):
      return "BUY";
      break;
    case(1):
      return "SELL";
      break;
    case(2):
      return "BUY_LIMIT";
      break;
    case(3):
      return "SELL_LIMIT";
      break;
    case(4):
      return "BUY_STOP";
      break;
    case(5):
      return "SELL_STOP";
      break;
    default:
      return "";
  }
}