//+------------------------------------------------------------------+
//|                                             Close All Orders.mq4 |
//|                                                       Hadi Zhang |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Hadi Zhang"

//--- input parameters
int      Slippage=3;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   //Create the buttons
  //Close All Orders Button
  ObjectCreate(0, "CloseButton", OBJ_BUTTON, 0, 0, 0);
  ObjectSetInteger(0, "CloseButton", OBJPROP_XDISTANCE, 25);
  ObjectSetInteger(0, "CloseButton", OBJPROP_YDISTANCE, 25);
  ObjectSetInteger(0, "CloseButton", OBJPROP_XSIZE, 150);
  ObjectSetInteger(0, "CloseButton", OBJPROP_YSIZE, 30);
  ObjectSetString(0, "CloseButton", OBJPROP_TEXT, "Close All Orders");
   ObjectSetInteger(0, "CloseButton", OBJPROP_BGCOLOR, White);
	ObjectSetInteger(0, "CloseButton", OBJPROP_HIDDEN, true);
	ObjectSetInteger(0, "CloseButton", OBJPROP_STATE, false);
	ObjectSetInteger(0, "CloseButton", OBJPROP_FONTSIZE, 12);

   //Close Sell Orders
   ObjectCreate(0, "CloseSellButton", OBJ_BUTTON, 0, 0, 0);
  ObjectSetInteger(0, "CloseSellButton", OBJPROP_XDISTANCE, 25);
  ObjectSetInteger(0, "CloseSellButton", OBJPROP_YDISTANCE, 65);
  ObjectSetInteger(0, "CloseSellButton", OBJPROP_XSIZE, 150);
  ObjectSetInteger(0, "CloseSellButton", OBJPROP_YSIZE, 30);
  ObjectSetString(0, "CloseSellButton", OBJPROP_TEXT, "Close Sell Orders");
   ObjectSetInteger(0, "CloseSellButton", OBJPROP_BGCOLOR, White);
	ObjectSetInteger(0, "CloseSellButton", OBJPROP_HIDDEN, true);
	ObjectSetInteger(0, "CloseSellButton", OBJPROP_STATE, false);
	ObjectSetInteger(0, "CloseSellButton", OBJPROP_FONTSIZE, 12);
	
   //Close Buy Orders
   ObjectCreate(0, "CloseBuyButton", OBJ_BUTTON, 0, 0, 0);
  ObjectSetInteger(0, "CloseBuyButton", OBJPROP_XDISTANCE, 25);
  ObjectSetInteger(0, "CloseBuyButton", OBJPROP_YDISTANCE, 105);
  ObjectSetInteger(0, "CloseBuyButton", OBJPROP_XSIZE, 150);
  ObjectSetInteger(0, "CloseBuyButton", OBJPROP_YSIZE, 30);
  ObjectSetString(0, "CloseBuyButton", OBJPROP_TEXT, "Close Buy Orders");
   ObjectSetInteger(0, "CloseBuyButton", OBJPROP_BGCOLOR, White);
	ObjectSetInteger(0, "CloseBuyButton", OBJPROP_HIDDEN, true);
	ObjectSetInteger(0, "CloseBuyButton", OBJPROP_STATE, false);
	ObjectSetInteger(0, "CloseBuyButton", OBJPROP_FONTSIZE, 12);
	
   //Close Orders in Profit
   ObjectCreate(0, "CloseProfitButton", OBJ_BUTTON, 0, 0, 0);
  ObjectSetInteger(0, "CloseProfitButton", OBJPROP_XDISTANCE, 25);
  ObjectSetInteger(0, "CloseProfitButton", OBJPROP_YDISTANCE, 145);
  ObjectSetInteger(0, "CloseProfitButton", OBJPROP_XSIZE, 150);
  ObjectSetInteger(0, "CloseProfitButton", OBJPROP_YSIZE, 30);
  ObjectSetString(0, "CloseProfitButton", OBJPROP_TEXT, "Close Profit Orders");
   ObjectSetInteger(0, "CloseProfitButton", OBJPROP_BGCOLOR, White);
	ObjectSetInteger(0, "CloseProfitButton", OBJPROP_HIDDEN, true);
	ObjectSetInteger(0, "CloseProfitButton", OBJPROP_STATE, false);
	ObjectSetInteger(0, "CloseProfitButton", OBJPROP_FONTSIZE, 12);
	
   //Close Orders in Loss
   ObjectCreate(0, "CloseLossButton", OBJ_BUTTON, 0, 0, 0);
  ObjectSetInteger(0, "CloseLossButton", OBJPROP_XDISTANCE, 25);
  ObjectSetInteger(0, "CloseLossButton", OBJPROP_YDISTANCE, 185);
  ObjectSetInteger(0, "CloseLossButton", OBJPROP_XSIZE, 150);
  ObjectSetInteger(0, "CloseLossButton", OBJPROP_YSIZE, 30);
  ObjectSetString(0, "CloseLossButton", OBJPROP_TEXT, "Close Loss Orders");
   ObjectSetInteger(0, "CloseLossButton", OBJPROP_BGCOLOR, White);
	ObjectSetInteger(0, "CloseLossButton", OBJPROP_HIDDEN, true);
	ObjectSetInteger(0, "CloseLossButton", OBJPROP_STATE, false);
	ObjectSetInteger(0, "CloseLossButton", OBJPROP_FONTSIZE, 12);
	
	
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   ObjectDelete(0, "CloseButton");
   ObjectDelete(0, "CloseSellButton");
   ObjectDelete(0, "CloseBuyButton");
   ObjectDelete(0, "CloseProfitButton");
   ObjectDelete(0, "CloseLossButton");
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   ObjectSetInteger(0, "CloseButton", OBJPROP_BGCOLOR, White);
   int success = 0;
   //If buttonspr was clicked
   if (id == CHARTEVENT_OBJECT_CLICK) {
       if (sparam == "CloseButton") success = deleteOrders() ? 2 : 1;
       else if (sparam == "CloseSellButton") success = deleteSellOrders() ? 2 : 1;
       else if (sparam == "CloseBuyButton") success = deleteBuyOrders() ? 2 : 1;
       else if (sparam == "CloseProfitButton") success = deleteOrdersInProfit() ? 2 : 1;
       else if (sparam == "CloseLossButton") success = deleteOrdersInLoss() ? 2 : 1;
   }
    if (success == 2)
    {
    	//Change button color to green
      ObjectSetInteger(0, sparam, OBJPROP_BGCOLOR, Green);
      //Sleep then change button color back to normal
      Sleep(200);
      ObjectSetInteger(0, sparam, OBJPROP_BGCOLOR, White);
      ObjectSetInteger(0, sparam, OBJPROP_STATE, false);
    }
    else if (success == 1)
    {
    	//Change button color to red
      ObjectSetInteger(0, sparam, OBJPROP_BGCOLOR, Red);
      //Sleep then change button color back to normal
      Sleep(200);
      ObjectSetInteger(0, sparam, OBJPROP_BGCOLOR, White);
      ObjectSetInteger(0, sparam, OBJPROP_STATE, false);
    }
    
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| function to handle order deletion                                |
//+------------------------------------------------------------------+
bool deleteOrders()
{
  bool success = true;
	//Loop backwards through all of the orders while OrdersTotal is not zero
  for (int i = OrdersTotal() - 1; i >= 0; --i) 
  {  
  	//Select the first ticket
    if (OrderSelect(i, SELECT_BY_POS))
    {
    	Print("Order selected is #", OrderTicket());
    }
    else
    {
    	Alert("OrderSelect returned the error of ", GetLastError());
      success = false;
      continue;
    }
    //Check whether order is sell
    if (OrderType() == OP_SELL)
    {
			if (!OrderClose(OrderTicket(), OrderLots(), Bid, Slippage))
      {
      	Alert("Order #", OrderTicket(), " was not closed");
        success = false;
      }
    }
    //Check whether order is buy
    else if (OrderType() == OP_BUY)
    {
    	if (!OrderClose(OrderTicket(), OrderLots(), Ask, Slippage))
      {
      	Alert("Order #", OrderTicket(), " was not closed");
        success = false;
      }
    }
    //Otherwise simply delete
    else 
    {
    	if (!OrderDelete(OrderTicket()))
      {
      	Alert("Pending Order #", OrderTicket(), "was not closed");
        success = false;
      }
    }
  }
  return success;
}

bool deleteSellOrders()
{
  bool success = true;
	//Loop backwards through all of the orders while OrdersTotal is not zero
  for (int i = OrdersTotal() - 1; i >= 0; --i) 
  {  
  	//Select the first ticket
    if (OrderSelect(i, SELECT_BY_POS))
    {
    	Print("Order selected is #", OrderTicket());
    }
    else
    {
    	Alert("OrderSelect returned the error of ", GetLastError());
      success = false;
      continue;
    }
    //Check whether order is sell
    if (OrderType() == OP_SELL)
    {
      if (!OrderClose(OrderTicket(), OrderLots(), Bid, Slippage))
      {
      	Alert("Order #", OrderTicket(), " was not closed");
        success = false;
      }
    }
  }
  return success;
}

bool deleteBuyOrders()
{
  bool success = true;
	//Loop backwards through all of the orders while OrdersTotal is not zero
  for (int i = OrdersTotal() - 1; i >= 0; --i) 
  {  
  	//Select the first ticket
    if (OrderSelect(i, SELECT_BY_POS))
    {
    	Print("Order selected is #", OrderTicket());
    }
    else
    {
    	Alert("OrderSelect returned the error of ", GetLastError());
      success = false;
      continue;
    }
    //Check whether order is sell
    if (OrderType() == OP_BUY)
    {
      if (!OrderClose(OrderTicket(), OrderLots(), Ask, Slippage))
      {
      	Alert("Order #", OrderTicket(), " was not closed");
        success = false;
      }
    }
  }
  return success;
}

bool deleteOrdersInProfit()
{
  bool success = true;
	//Loop backwards through all of the orders while OrdersTotal is not zero
  for (int i = OrdersTotal() - 1; i >= 0; --i) 
  {  
  	//Select the first ticket
    if (OrderSelect(i, SELECT_BY_POS))
    {
    	Print("Order selected is #", OrderTicket());
    }
    else
    {
    	Alert("OrderSelect returned the error of ", GetLastError());
      success = false;
      continue;
    }
    //Check whether order is sell and has made profit
    if (OrderType() == OP_SELL && OrderProfit() > 0)
    {
	if (!OrderClose(OrderTicket(), OrderLots(), Bid, Slippage))
      {
      	Alert("Order #", OrderTicket(), " was not closed");
        success = false;
      }
    }
    //Check whether order is buy and has made profit
    else if (OrderType() == OP_BUY && OrderProfit() > 0)
    {
    	if (!OrderClose(OrderTicket(), OrderLots(), Ask, Slippage))
      {
      	Alert("Order #", OrderTicket(), " was not closed");
        success = false;
      }
    }
  }
  return success;
}

bool deleteOrdersInLoss()
{
  bool success = true;
	//Loop backwards through all of the orders while OrdersTotal is not zero
  for (int i = OrdersTotal() - 1; i >= 0; --i) 
  {  
  	//Select the first ticket
    if (OrderSelect(i, SELECT_BY_POS))
    {
    	Print("Order selected is #", OrderTicket());
    }
    else
    {
    	Alert("OrderSelect returned the error of ", GetLastError());
      success = false;
      continue;
    }
    //Check whether order is sell and has loss
    if (OrderType() == OP_SELL && OrderProfit() < 0)
    {
	if (!OrderClose(OrderTicket(), OrderLots(), Bid, Slippage))
      {
      	Alert("Order #", OrderTicket(), " was not closed");
        success = false;
      }
    }
    //Check whether order is buy and has loss
    else if (OrderType() == OP_BUY && OrderProfit() < 0)
    {
    	if (!OrderClose(OrderTicket(), OrderLots(), Ask, Slippage))
      {
      	Alert("Order #", OrderTicket(), " was not closed");
        success = false;
      }
    }
  }
  return success;
}

