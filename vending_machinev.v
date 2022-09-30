module vending_machine(costOfTicket, moneyToPay, totalMoney, clk, reset, howManyTicket, origin, destination, money);
  // input clk, howManyTicket, origin, destination, money;
  // output costOfTicket, moneyToPay, totalMoney;
  input clk, reset;
  input[2:0] howManyTicket, origin, destination;
  input[5:0] money; // Max 50 
  
  //output [2:0] state, next_state;
  output[7:0] costOfTicket, moneyToPay, totalMoney;
  reg[7:0] costOfTicket, moneyToPay, totalMoney;

  parameter s0 = 3'd0; //choose destination orgin station
  parameter s1 = 3'd1; //choose howManyTicket
  parameter s2 = 3'd2; //pay
  parameter s3 = 3'd3; //give ticked and change

  reg [2:0] state;
  reg [2:0] next_state;

  reg check1, check2, temp ;
  always @(posedge clk)begin
    if(reset) begin
      state <= s0;
      next_state <= s0;
      costOfTicket <= 7'd0;
      moneyToPay <= 7'd0;
      totalMoney <= 7'd0;
    end 
    else 
      state <= next_state;
  end

  always @(state or posedge clk) begin
    case (state)
        s0: ;  //no need to do
        s1: costOfTicket <= howManyTicket * (5 + (destination - origin) * 5) ;  
        s2: begin
          totalMoney <= totalMoney + money;
          moneyToPay <= costOfTicket - totalMoney ;
        end
        s3: ;
    endcase
  end

  always @(state or posedge clk) begin
    case (state)
      s0: begin
        check1 <= origin != 0 ? ( destination != 0 ? 1 : 0 ) : 0 ;
        if( check1 ) next_state <= s1;
        else next_state <= s0;
      end
      s1: begin
        if( howManyTicket != 0 ) next_state <= s2;
        else next_state <= s1;
      end
      s2: begin
        if( costOfTicket <=  totalMoney ) next_state <= s3;
        else next_state <= s2;
      end
      s3: next_state <= s0;
      default:next_state <= s0;
    endcase
  end

initial begin
  $monitor( "@ %3t : check %d\tOrigin : %d, Destination: %d,\tAmount of Tickets : %d,\tcostOfTicket: %d,\t totalMoney: %d,\tmoney: %d,\tmoneyToPay: %d", $time, check1, origin, destination, howManyTicket, costOfTicket, totalMoney, money, moneyToPay);
end

endmodule //
