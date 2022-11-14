`default_nettype none

module phasenoisepon_seven_segment_seconds #( parameter MAX_COUNT = 1000 ) (
  input [7:0] io_in,
  output [7:0] io_out
);
    
    // setup registers
    reg [3:0] nibble_low;
    reg [3:0] nibble_high;
    reg [7:0] output_reg;

    // declare wires
    wire clk = io_in[0];
    wire reset = io_in[1];
    wire [1:0] ctl = io_in[3:2];
    wire [3:0] data_in = io_in[7:4];
    assign io_out[7:0] = output_reg;

    // define useful FSM states
    localparam CTL_LOW_NIBBLE  = 2'b00;
    localparam CTL_HIGH_NIBBLE = 2'b01;

    always @(posedge clk) begin
        // if reset, then reset all reg's to 0
        if (reset) begin
            nibble_low <= 0;
            nibble_high <= 0;
            output_reg <= 0;
        end else begin
            // read control lines
            if (ctl == CTL_LOW_NIBBLE) begin
                output_reg <= 8'h0F;
                nibble_low <= data_in;
            end else if (ctl == CTL_HIGH_NIBBLE) begin
                output_reg <= 8'hF0;
                nibble_high <= data_in;
            end else if (ctl[1] == 1'b1) begin
                //output_reg <= 8'hFF; // stub
                case ({nibble_high,nibble_low})
                    8'h61: output_reg <= 8'h6e; //rot13(0x61)=0x6e, a->n
                    8'h62: output_reg <= 8'h6f; //rot13(0x62)=0x6f, b->o
                    8'h63: output_reg <= 8'h70; //rot13(0x63)=0x70, c->p
                    8'h64: output_reg <= 8'h71; //rot13(0x64)=0x71, d->q
                    8'h65: output_reg <= 8'h72; //rot13(0x65)=0x72, e->r
                    8'h66: output_reg <= 8'h73; //rot13(0x66)=0x73, f->s
                    8'h67: output_reg <= 8'h74; //rot13(0x67)=0x74, g->t
                    8'h68: output_reg <= 8'h75; //rot13(0x68)=0x75, h->u
                    8'h69: output_reg <= 8'h76; //rot13(0x69)=0x76, i->v
                    8'h6a: output_reg <= 8'h77; //rot13(0x6a)=0x77, j->w
                    8'h6b: output_reg <= 8'h78; //rot13(0x6b)=0x78, k->x
                    8'h6c: output_reg <= 8'h79; //rot13(0x6c)=0x79, l->y
                    8'h6d: output_reg <= 8'h7a; //rot13(0x6d)=0x7a, m->z
                    8'h6e: output_reg <= 8'h61; //rot13(0x6e)=0x61, n->a
                    8'h6f: output_reg <= 8'h62; //rot13(0x6f)=0x62, o->b
                    8'h70: output_reg <= 8'h63; //rot13(0x70)=0x63, p->c
                    8'h71: output_reg <= 8'h64; //rot13(0x71)=0x64, q->d
                    8'h72: output_reg <= 8'h65; //rot13(0x72)=0x65, r->e
                    8'h73: output_reg <= 8'h66; //rot13(0x73)=0x66, s->f
                    8'h74: output_reg <= 8'h67; //rot13(0x74)=0x67, t->g
                    8'h75: output_reg <= 8'h68; //rot13(0x75)=0x68, u->h
                    8'h76: output_reg <= 8'h69; //rot13(0x76)=0x69, v->i
                    8'h77: output_reg <= 8'h6a; //rot13(0x77)=0x6a, w->j
                    8'h78: output_reg <= 8'h6b; //rot13(0x78)=0x6b, x->k
                    8'h79: output_reg <= 8'h6c; //rot13(0x79)=0x6c, y->l
                    8'h7a: output_reg <= 8'h6d; //rot13(0x7a)=0x6d, z->m
                    8'h41: output_reg <= 8'h4e; //rot13(0x41)=0x4e, A->N
                    8'h42: output_reg <= 8'h4f; //rot13(0x42)=0x4f, B->O
                    8'h43: output_reg <= 8'h50; //rot13(0x43)=0x50, C->P
                    8'h44: output_reg <= 8'h51; //rot13(0x44)=0x51, D->Q
                    8'h45: output_reg <= 8'h52; //rot13(0x45)=0x52, E->R
                    8'h46: output_reg <= 8'h53; //rot13(0x46)=0x53, F->S
                    8'h47: output_reg <= 8'h54; //rot13(0x47)=0x54, G->T
                    8'h48: output_reg <= 8'h55; //rot13(0x48)=0x55, H->U
                    8'h49: output_reg <= 8'h56; //rot13(0x49)=0x56, I->V
                    8'h4a: output_reg <= 8'h57; //rot13(0x4a)=0x57, J->W
                    8'h4b: output_reg <= 8'h58; //rot13(0x4b)=0x58, K->X
                    8'h4c: output_reg <= 8'h59; //rot13(0x4c)=0x59, L->Y
                    8'h4d: output_reg <= 8'h5a; //rot13(0x4d)=0x5a, M->Z
                    8'h4e: output_reg <= 8'h41; //rot13(0x4e)=0x41, N->A
                    8'h4f: output_reg <= 8'h42; //rot13(0x4f)=0x42, O->B
                    8'h50: output_reg <= 8'h43; //rot13(0x50)=0x43, P->C
                    8'h51: output_reg <= 8'h44; //rot13(0x51)=0x44, Q->D
                    8'h52: output_reg <= 8'h45; //rot13(0x52)=0x45, R->E
                    8'h53: output_reg <= 8'h46; //rot13(0x53)=0x46, S->F
                    8'h54: output_reg <= 8'h47; //rot13(0x54)=0x47, T->G
                    8'h55: output_reg <= 8'h48; //rot13(0x55)=0x48, U->H
                    8'h56: output_reg <= 8'h49; //rot13(0x56)=0x49, V->I
                    8'h57: output_reg <= 8'h4a; //rot13(0x57)=0x4a, W->J
                    8'h58: output_reg <= 8'h4b; //rot13(0x58)=0x4b, X->K
                    8'h59: output_reg <= 8'h4c; //rot13(0x59)=0x4c, Y->L
                    8'h5a: output_reg <= 8'h4d; //rot13(0x5a)=0x4d, Z->M
                    default: output_reg <= 0; //should cause a noticeable error in the TB
                endcase
            end
        end
    end

endmodule
