final errorTrade = {
  "TradeID": "poo",
  "TradeDate": "poo",
  "Buy/Sell": "poo",
  "AssetClass": "poo",
  "UnderlyingSymbol": "poo",
  "Quantity": "poo",
  "Strike": "1.poo",
  "Expiry": "poo",
  "Put/Call": "poo",
  "Price": "poo",
  "Proceeds": "poo",
  "Commission": "poo",
  "Description": "poo",
  "Multiplier": "poo",
  "Code": "poo",
  "CurrencyPrimary": "poo",
  "Symbol": "poo"
};

final validOptionTrade = {
  "TradeID": "3200040928",
  "TradeDate": "20201105",
  "Buy/Sell": "SELL",
  "AssetClass": "OPT",
  "UnderlyingSymbol": "BP.",
  "Quantity": "-1",
  "Strike": "1.8",
  "Expiry": "20201218",
  "Put/Call": "P",
  "Price": "0.03",
  "Proceeds": "30",
  "Commission": "-1.7",
  "Description": "BP. 18DEC20 1.8 P",
  "Multiplier": "1000",
  "Code": "O",
  "CurrencyPrimary": "GBP",
  "Symbol": "BP DEC20 1.8 P"
};

final invalidOptionTrade = {
  "TradeID": "3200040928",
  "TradeDate": "20201105",
  "Buy/Sell": "SELL",
  "AssetClass": "OPT",
  "UnderlyingSymbol": "BP.",
  "Quantity": "-1",
  "Strike": "poo",
  "Expiry": "poo",
  "Put/Call": "poo",
  "Price": "0.03",
  "Proceeds": "30",
  "Commission": "-1.7",
  "Description": "BP. 18DEC20 1.8 P",
  "Multiplier": "1000",
  "Code": "O",
  "CurrencyPrimary": "GBP",
  "Symbol": "BP DEC20 1.8 P"
};

// ignore: non_constant_identifier_names
final UKOptionTrade = {
  "TradeID": "3317499753",
  "TradeDate": "20201222",
  "Buy/Sell": "SELL",
  "AssetClass": "OPT",
  "UnderlyingSymbol": "BLND",
  "Quantity": "-1",
  "Strike": "4.4",
  "Expiry": "20210115",
  "Put/Call": "P",
  "Price": "0.1",
  "Proceeds": "100",
  "Commission": "-1.7",
  "Description": "BLND 15JAN21 4.4 P",
  "Multiplier": "1000",
  "Code": "O",
  "CurrencyPrimary": "GBP",
  "Symbol": "BLC JAN21 4.4 P"
};

// ignore: non_constant_identifier_names
final USStockTrade = {
  "TradeDate": "20220121",
  "Buy/Sell": "SELL",
  "Quantity": "-100",
  "Symbol": "ATVI",
  "Expiry": "",
  "Strike": "",
  "Put/Call": "",
  "TradePrice": "65",
  "Proceeds": "6500",
  "IBCommission": "-0.04615",
  "NetCash": "6499.95385",
  "AssetClass": "STK",
  "Open/CloseIndicator": "C",
  "Multiplier": "1",
  "Notes/Codes": "A",
  "UnderlyingSymbol": "",
  "TradeID": "4416707873",
  "CurrencyPrimary": "USD",
  "FXRateToBase": "0.7378",
  "Description": "ACTIVISION BLIZZARD INC"
};

const openOptionTrade = {
  "TradeID": "3203601781",
  "TradeDate": "20201106",
  "Buy/Sell": "SELL",
  "AssetClass": "OPT",
  "UnderlyingSymbol": "SBRY",
  "Quantity": "-1",
  "Strike": "1.8",
  "Expiry": "20201120",
  "Put/Call": "P",
  "Price": "0.025",
  "Proceeds": "25",
  "Commission": "-1.7",
  "Description": "SBRY 20NOV20 1.8 P",
  "Multiplier": "1000",
  "Code": "O",
  "CurrencyPrimary": "GBP",
  "Symbol": "SAN NOV20 1.8 P"
};

const closeOptionTrade = {
  "TradeID": "3242658734",
  "TradeDate": "20201120",
  "Buy/Sell": "BUY",
  "AssetClass": "OPT",
  "UnderlyingSymbol": "SBRY",
  "Quantity": "1",
  "Strike": "1.8",
  "Expiry": "20201120",
  "Put/Call": "P",
  "Price": "0.0",
  "Proceeds": "0",
  "Commission": "0",
  "Description": "SBRY 20NOV20 1.8 P",
  "Multiplier": "1000",
  "Code": "C;Ep",
  "CurrencyPrimary": "GBP",
  "Symbol": "SAN NOV20 1.8 P"
};

const openUSStockTrade = {
  "TradeDate": "20220121",
  "Buy/Sell": "BUY",
  "Quantity": "100",
  "Symbol": "BMBL",
  "Expiry": "",
  "Strike": "",
  "Put/Call": "",
  "TradePrice": "45",
  "Proceeds": "-4500",
  "IBCommission": "1.23",
  "NetCash": "-4501.23",
  "AssetClass": "STK",
  "Open/CloseIndicator": "O",
  "Multiplier": "1",
  "Notes/Codes": "A",
  "UnderlyingSymbol": "",
  "TradeID": "4416622310",
  "CurrencyPrimary": "USD",
  "FXRateToBase": "0.7378",
  "Description": "BUMBLE INC-A"
};

const openULVR = {
  "TradeID": "3561483446",
  "TradeDate": "20210302",
  "Buy/Sell": "BUY",
  "AssetClass": "STK",
  "UnderlyingSymbol": "",
  "Quantity": "400",
  "Strike": "",
  "Expiry": "",
  "Put/Call": "",
  "Price": "38.15",
  "Proceeds": "-15260",
  "Commission": "-6",
  "Description": "UNILEVER PLC",
  "Multiplier": "1",
  "Code": "O",
  "CurrencyPrimary": "GBP",
  "Symbol": "ULVR"
};

const addULVR = {
  "TradeID": "3614881974",
  "TradeDate": "20210316",
  "Buy/Sell": "BUY",
  "AssetClass": "STK",
  "UnderlyingSymbol": "",
  "Quantity": "200",
  "Strike": "",
  "Expiry": "",
  "Put/Call": "",
  "Price": "39.88",
  "Proceeds": "-7976",
  "Commission": "-6",
  "Description": "UNILEVER PLC",
  "Multiplier": "1",
  "Code": "O",
  "CurrencyPrimary": "GBP",
  "Symbol": "ULVR"
};

const closeULVR = {
  "TradeID": "3614881975",
  "TradeDate": "20210326",
  "Buy/Sell": "SELL",
  "AssetClass": "STK",
  "UnderlyingSymbol": "",
  "Quantity": "-600",
  "Strike": "",
  "Expiry": "",
  "Put/Call": "",
  "Price": "398.80",
  "Proceeds": "79760",
  "Commission": "-60",
  "Description": "UNILEVER PLC",
  "Multiplier": "1",
  "Code": "O",
  "CurrencyPrimary": "GBP",
  "Symbol": "ULVR"
};

const openGSK = {
  "TradeID": "3313178960",
  "TradeDate": "20201221",
  "Buy/Sell": "SELL",
  "AssetClass": "OPT",
  "UnderlyingSymbol": "GSK",
  "Quantity": "-1",
  "Strike": "13",
  "Expiry": "20210219",
  "Put/Call": "P",
  "Price": "0.33",
  "Proceeds": "330",
  "Commission": "-1.7",
  "Description": "GSK 19FEB21 13.0 P",
  "Multiplier": "1000",
  "Code": "O",
  "CurrencyPrimary": "GBP",
  "Symbol": "GXO FEB21 13 P"
};

const addGSK = {
  "TradeID": "3313178960",
  "TradeDate": "20201222",
  "Buy/Sell": "SELL",
  "AssetClass": "OPT",
  "UnderlyingSymbol": "GSK",
  "Quantity": "-1",
  "Strike": "13",
  "Expiry": "20210219",
  "Put/Call": "P",
  "Price": "0.33",
  "Proceeds": "330",
  "Commission": "-1.7",
  "Description": "GSK 19FEB21 13.0 P",
  "Multiplier": "1000",
  "Code": "O",
  "CurrencyPrimary": "GBP",
  "Symbol": "GXO FEB21 13 P"
};

const closeGSK = {
  "TradeID": "3313178960",
  "TradeDate": "20201221",
  "Buy/Sell": "BUY",
  "AssetClass": "OPT",
  "UnderlyingSymbol": "GSK",
  "Quantity": "2",
  "Strike": "13",
  "Expiry": "20210219",
  "Put/Call": "P",
  "Price": "0",
  "Proceeds": "0",
  "Commission": "0",
  "Description": "GSK 19FEB21 13.0 P",
  "Multiplier": "1000",
  "Code": "C;Ep",
  "CurrencyPrimary": "GBP",
  "Symbol": "GXO FEB21 13 P"
};