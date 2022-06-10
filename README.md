# Trade Log Server
A RESTful API written in dart to host stock and option trades as well as record dividends.

## Data Model
+ Trade
+ Position
+ Stock
+ Portfolio

Parameters in order of priority
1. command line argument
2. environment variable
3. constants files

            
LONG        OPEN    CLOSE
 STOCK      cash    -cash
 CALL       cash    -cash
 PUT        cash    -cash

SHORT       OPEN    CLOSE
  STOCK     infin   -infin
  CALL      infin   -infin  
  PUT       calc    -calc
