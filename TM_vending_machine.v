`timescale 1ns/1ns     
module TM_vending_machine;

    // Inputs
  reg clk, reset;
  reg[2:0] howManyTicket, origin, destination;
  reg[5:0] money; // Max 50 

    // Outputs
  wire[7:0] costOfTicket, moneyToPay, totalMoney;
  wire[2:0] state, next_state;
  vending_machine U_vending_machine( .costOfTicket(costOfTicket), .moneyToPay(moneyToPay), .totalMoney(totalMoney), .clk(clk), .reset(reset), 
                                     .howManyTicket(howManyTicket), .origin(origin), .destination(destination), .money(money));

  always #5  clk=~clk;
  initial begin
    //Apply inputs
    clk = 1;
    reset = 1;
    howManyTicket = 3'd0;
    origin = 3'd0;
    destination = 3'd0;
    money = 6'd0;

    #5 reset = 0 ;

    #10 origin = 1;
    #10 destination = 5;
    #10 howManyTicket = 4;

    #25 money = 50 ;
    #10 money = 50 ;
    #10 money = 1;
    #10 money = 5 ;
    #10 money = 50 ;
    #10 money = 50 ;


    #10  $stop;
  end
endmodule
