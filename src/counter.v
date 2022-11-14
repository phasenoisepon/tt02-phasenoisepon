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
                    8'h00: output_reg <= 8'h63; //s(0x00)=0x63
                    8'h01: output_reg <= 8'h7c; //s(0x01)=0x7c
                    8'h02: output_reg <= 8'h77; //s(0x02)=0x77
                    8'h03: output_reg <= 8'h7b; //s(0x03)=0x7b
                    8'h04: output_reg <= 8'hf2; //s(0x04)=0xf2
                    8'h05: output_reg <= 8'h6b; //s(0x05)=0x6b
                    8'h06: output_reg <= 8'h6f; //s(0x06)=0x6f
                    8'h07: output_reg <= 8'hc5; //s(0x07)=0xc5
                    8'h08: output_reg <= 8'h30; //s(0x08)=0x30
                    8'h09: output_reg <= 8'h01; //s(0x09)=0x01
                    8'h0a: output_reg <= 8'h67; //s(0x0a)=0x67
                    8'h0b: output_reg <= 8'h2b; //s(0x0b)=0x2b
                    8'h0c: output_reg <= 8'hfe; //s(0x0c)=0xfe
                    8'h0d: output_reg <= 8'hd7; //s(0x0d)=0xd7
                    8'h0e: output_reg <= 8'hab; //s(0x0e)=0xab
                    8'h0f: output_reg <= 8'h76; //s(0x0f)=0x76
                    8'h10: output_reg <= 8'hca; //s(0x10)=0xca
                    8'h11: output_reg <= 8'h82; //s(0x11)=0x82
                    8'h12: output_reg <= 8'hc9; //s(0x12)=0xc9
                    8'h13: output_reg <= 8'h7d; //s(0x13)=0x7d
                    8'h14: output_reg <= 8'hfa; //s(0x14)=0xfa
                    8'h15: output_reg <= 8'h59; //s(0x15)=0x59
                    8'h16: output_reg <= 8'h47; //s(0x16)=0x47
                    8'h17: output_reg <= 8'hf0; //s(0x17)=0xf0
                    8'h18: output_reg <= 8'had; //s(0x18)=0xad
                    8'h19: output_reg <= 8'hd4; //s(0x19)=0xd4
                    8'h1a: output_reg <= 8'ha2; //s(0x1a)=0xa2
                    8'h1b: output_reg <= 8'haf; //s(0x1b)=0xaf
                    8'h1c: output_reg <= 8'h9c; //s(0x1c)=0x9c
                    8'h1d: output_reg <= 8'ha4; //s(0x1d)=0xa4
                    8'h1e: output_reg <= 8'h72; //s(0x1e)=0x72
                    8'h1f: output_reg <= 8'hc0; //s(0x1f)=0xc0
                    8'h20: output_reg <= 8'hb7; //s(0x20)=0xb7
                    8'h21: output_reg <= 8'hfd; //s(0x21)=0xfd
                    8'h22: output_reg <= 8'h93; //s(0x22)=0x93
                    8'h23: output_reg <= 8'h26; //s(0x23)=0x26
                    8'h24: output_reg <= 8'h36; //s(0x24)=0x36
                    8'h25: output_reg <= 8'h3f; //s(0x25)=0x3f
                    8'h26: output_reg <= 8'hf7; //s(0x26)=0xf7
                    8'h27: output_reg <= 8'hcc; //s(0x27)=0xcc
                    8'h28: output_reg <= 8'h34; //s(0x28)=0x34
                    8'h29: output_reg <= 8'ha5; //s(0x29)=0xa5
                    8'h2a: output_reg <= 8'he5; //s(0x2a)=0xe5
                    8'h2b: output_reg <= 8'hf1; //s(0x2b)=0xf1
                    8'h2c: output_reg <= 8'h71; //s(0x2c)=0x71
                    8'h2d: output_reg <= 8'hd8; //s(0x2d)=0xd8
                    8'h2e: output_reg <= 8'h31; //s(0x2e)=0x31
                    8'h2f: output_reg <= 8'h15; //s(0x2f)=0x15
                    8'h30: output_reg <= 8'h04; //s(0x30)=0x04
                    8'h31: output_reg <= 8'hc7; //s(0x31)=0xc7
                    8'h32: output_reg <= 8'h23; //s(0x32)=0x23
                    8'h33: output_reg <= 8'hc3; //s(0x33)=0xc3
                    8'h34: output_reg <= 8'h18; //s(0x34)=0x18
                    8'h35: output_reg <= 8'h96; //s(0x35)=0x96
                    8'h36: output_reg <= 8'h05; //s(0x36)=0x05
                    8'h37: output_reg <= 8'h9a; //s(0x37)=0x9a
                    8'h38: output_reg <= 8'h07; //s(0x38)=0x07
                    8'h39: output_reg <= 8'h12; //s(0x39)=0x12
                    8'h3a: output_reg <= 8'h80; //s(0x3a)=0x80
                    8'h3b: output_reg <= 8'he2; //s(0x3b)=0xe2
                    8'h3c: output_reg <= 8'heb; //s(0x3c)=0xeb
                    8'h3d: output_reg <= 8'h27; //s(0x3d)=0x27
                    8'h3e: output_reg <= 8'hb2; //s(0x3e)=0xb2
                    8'h3f: output_reg <= 8'h75; //s(0x3f)=0x75
                    8'h40: output_reg <= 8'h09; //s(0x40)=0x09
                    8'h41: output_reg <= 8'h83; //s(0x41)=0x83
                    8'h42: output_reg <= 8'h2c; //s(0x42)=0x2c
                    8'h43: output_reg <= 8'h1a; //s(0x43)=0x1a
                    8'h44: output_reg <= 8'h1b; //s(0x44)=0x1b
                    8'h45: output_reg <= 8'h6e; //s(0x45)=0x6e
                    8'h46: output_reg <= 8'h5a; //s(0x46)=0x5a
                    8'h47: output_reg <= 8'ha0; //s(0x47)=0xa0
                    8'h48: output_reg <= 8'h52; //s(0x48)=0x52
                    8'h49: output_reg <= 8'h3b; //s(0x49)=0x3b
                    8'h4a: output_reg <= 8'hd6; //s(0x4a)=0xd6
                    8'h4b: output_reg <= 8'hb3; //s(0x4b)=0xb3
                    8'h4c: output_reg <= 8'h29; //s(0x4c)=0x29
                    8'h4d: output_reg <= 8'he3; //s(0x4d)=0xe3
                    8'h4e: output_reg <= 8'h2f; //s(0x4e)=0x2f
                    8'h4f: output_reg <= 8'h84; //s(0x4f)=0x84
                    8'h50: output_reg <= 8'h53; //s(0x50)=0x53
                    8'h51: output_reg <= 8'hd1; //s(0x51)=0xd1
                    8'h52: output_reg <= 8'h00; //s(0x52)=0x00
                    8'h53: output_reg <= 8'hed; //s(0x53)=0xed
                    8'h54: output_reg <= 8'h20; //s(0x54)=0x20
                    8'h55: output_reg <= 8'hfc; //s(0x55)=0xfc
                    8'h56: output_reg <= 8'hb1; //s(0x56)=0xb1
                    8'h57: output_reg <= 8'h5b; //s(0x57)=0x5b
                    8'h58: output_reg <= 8'h6a; //s(0x58)=0x6a
                    8'h59: output_reg <= 8'hcb; //s(0x59)=0xcb
                    8'h5a: output_reg <= 8'hbe; //s(0x5a)=0xbe
                    8'h5b: output_reg <= 8'h39; //s(0x5b)=0x39
                    8'h5c: output_reg <= 8'h4a; //s(0x5c)=0x4a
                    8'h5d: output_reg <= 8'h4c; //s(0x5d)=0x4c
                    8'h5e: output_reg <= 8'h58; //s(0x5e)=0x58
                    8'h5f: output_reg <= 8'hcf; //s(0x5f)=0xcf
                    8'h60: output_reg <= 8'hd0; //s(0x60)=0xd0
                    8'h61: output_reg <= 8'hef; //s(0x61)=0xef
                    8'h62: output_reg <= 8'haa; //s(0x62)=0xaa
                    8'h63: output_reg <= 8'hfb; //s(0x63)=0xfb
                    8'h64: output_reg <= 8'h43; //s(0x64)=0x43
                    8'h65: output_reg <= 8'h4d; //s(0x65)=0x4d
                    8'h66: output_reg <= 8'h33; //s(0x66)=0x33
                    8'h67: output_reg <= 8'h85; //s(0x67)=0x85
                    8'h68: output_reg <= 8'h45; //s(0x68)=0x45
                    8'h69: output_reg <= 8'hf9; //s(0x69)=0xf9
                    8'h6a: output_reg <= 8'h02; //s(0x6a)=0x02
                    8'h6b: output_reg <= 8'h7f; //s(0x6b)=0x7f
                    8'h6c: output_reg <= 8'h50; //s(0x6c)=0x50
                    8'h6d: output_reg <= 8'h3c; //s(0x6d)=0x3c
                    8'h6e: output_reg <= 8'h9f; //s(0x6e)=0x9f
                    8'h6f: output_reg <= 8'ha8; //s(0x6f)=0xa8
                    8'h70: output_reg <= 8'h51; //s(0x70)=0x51
                    8'h71: output_reg <= 8'ha3; //s(0x71)=0xa3
                    8'h72: output_reg <= 8'h40; //s(0x72)=0x40
                    8'h73: output_reg <= 8'h8f; //s(0x73)=0x8f
                    8'h74: output_reg <= 8'h92; //s(0x74)=0x92
                    8'h75: output_reg <= 8'h9d; //s(0x75)=0x9d
                    8'h76: output_reg <= 8'h38; //s(0x76)=0x38
                    8'h77: output_reg <= 8'hf5; //s(0x77)=0xf5
                    8'h78: output_reg <= 8'hbc; //s(0x78)=0xbc
                    8'h79: output_reg <= 8'hb6; //s(0x79)=0xb6
                    8'h7a: output_reg <= 8'hda; //s(0x7a)=0xda
                    8'h7b: output_reg <= 8'h21; //s(0x7b)=0x21
                    8'h7c: output_reg <= 8'h10; //s(0x7c)=0x10
                    8'h7d: output_reg <= 8'hff; //s(0x7d)=0xff
                    8'h7e: output_reg <= 8'hf3; //s(0x7e)=0xf3
                    8'h7f: output_reg <= 8'hd2; //s(0x7f)=0xd2
                    8'h80: output_reg <= 8'hcd; //s(0x80)=0xcd
                    8'h81: output_reg <= 8'h0c; //s(0x81)=0x0c
                    8'h82: output_reg <= 8'h13; //s(0x82)=0x13
                    8'h83: output_reg <= 8'hec; //s(0x83)=0xec
                    8'h84: output_reg <= 8'h5f; //s(0x84)=0x5f
                    8'h85: output_reg <= 8'h97; //s(0x85)=0x97
                    8'h86: output_reg <= 8'h44; //s(0x86)=0x44
                    8'h87: output_reg <= 8'h17; //s(0x87)=0x17
                    8'h88: output_reg <= 8'hc4; //s(0x88)=0xc4
                    8'h89: output_reg <= 8'ha7; //s(0x89)=0xa7
                    8'h8a: output_reg <= 8'h7e; //s(0x8a)=0x7e
                    8'h8b: output_reg <= 8'h3d; //s(0x8b)=0x3d
                    8'h8c: output_reg <= 8'h64; //s(0x8c)=0x64
                    8'h8d: output_reg <= 8'h5d; //s(0x8d)=0x5d
                    8'h8e: output_reg <= 8'h19; //s(0x8e)=0x19
                    8'h8f: output_reg <= 8'h73; //s(0x8f)=0x73
                    8'h90: output_reg <= 8'h60; //s(0x90)=0x60
                    8'h91: output_reg <= 8'h81; //s(0x91)=0x81
                    8'h92: output_reg <= 8'h4f; //s(0x92)=0x4f
                    8'h93: output_reg <= 8'hdc; //s(0x93)=0xdc
                    8'h94: output_reg <= 8'h22; //s(0x94)=0x22
                    8'h95: output_reg <= 8'h2a; //s(0x95)=0x2a
                    8'h96: output_reg <= 8'h90; //s(0x96)=0x90
                    8'h97: output_reg <= 8'h88; //s(0x97)=0x88
                    8'h98: output_reg <= 8'h46; //s(0x98)=0x46
                    8'h99: output_reg <= 8'hee; //s(0x99)=0xee
                    8'h9a: output_reg <= 8'hb8; //s(0x9a)=0xb8
                    8'h9b: output_reg <= 8'h14; //s(0x9b)=0x14
                    8'h9c: output_reg <= 8'hde; //s(0x9c)=0xde
                    8'h9d: output_reg <= 8'h5e; //s(0x9d)=0x5e
                    8'h9e: output_reg <= 8'h0b; //s(0x9e)=0x0b
                    8'h9f: output_reg <= 8'hdb; //s(0x9f)=0xdb
                    8'ha0: output_reg <= 8'he0; //s(0xa0)=0xe0
                    8'ha1: output_reg <= 8'h32; //s(0xa1)=0x32
                    8'ha2: output_reg <= 8'h3a; //s(0xa2)=0x3a
                    8'ha3: output_reg <= 8'h0a; //s(0xa3)=0x0a
                    8'ha4: output_reg <= 8'h49; //s(0xa4)=0x49
                    8'ha5: output_reg <= 8'h06; //s(0xa5)=0x06
                    8'ha6: output_reg <= 8'h24; //s(0xa6)=0x24
                    8'ha7: output_reg <= 8'h5c; //s(0xa7)=0x5c
                    8'ha8: output_reg <= 8'hc2; //s(0xa8)=0xc2
                    8'ha9: output_reg <= 8'hd3; //s(0xa9)=0xd3
                    8'haa: output_reg <= 8'hac; //s(0xaa)=0xac
                    8'hab: output_reg <= 8'h62; //s(0xab)=0x62
                    8'hac: output_reg <= 8'h91; //s(0xac)=0x91
                    8'had: output_reg <= 8'h95; //s(0xad)=0x95
                    8'hae: output_reg <= 8'he4; //s(0xae)=0xe4
                    8'haf: output_reg <= 8'h79; //s(0xaf)=0x79
                    8'hb0: output_reg <= 8'he7; //s(0xb0)=0xe7
                    8'hb1: output_reg <= 8'hc8; //s(0xb1)=0xc8
                    8'hb2: output_reg <= 8'h37; //s(0xb2)=0x37
                    8'hb3: output_reg <= 8'h6d; //s(0xb3)=0x6d
                    8'hb4: output_reg <= 8'h8d; //s(0xb4)=0x8d
                    8'hb5: output_reg <= 8'hd5; //s(0xb5)=0xd5
                    8'hb6: output_reg <= 8'h4e; //s(0xb6)=0x4e
                    8'hb7: output_reg <= 8'ha9; //s(0xb7)=0xa9
                    8'hb8: output_reg <= 8'h6c; //s(0xb8)=0x6c
                    8'hb9: output_reg <= 8'h56; //s(0xb9)=0x56
                    8'hba: output_reg <= 8'hf4; //s(0xba)=0xf4
                    8'hbb: output_reg <= 8'hea; //s(0xbb)=0xea
                    8'hbc: output_reg <= 8'h65; //s(0xbc)=0x65
                    8'hbd: output_reg <= 8'h7a; //s(0xbd)=0x7a
                    8'hbe: output_reg <= 8'hae; //s(0xbe)=0xae
                    8'hbf: output_reg <= 8'h08; //s(0xbf)=0x08
                    8'hc0: output_reg <= 8'hba; //s(0xc0)=0xba
                    8'hc1: output_reg <= 8'h78; //s(0xc1)=0x78
                    8'hc2: output_reg <= 8'h25; //s(0xc2)=0x25
                    8'hc3: output_reg <= 8'h2e; //s(0xc3)=0x2e
                    8'hc4: output_reg <= 8'h1c; //s(0xc4)=0x1c
                    8'hc5: output_reg <= 8'ha6; //s(0xc5)=0xa6
                    8'hc6: output_reg <= 8'hb4; //s(0xc6)=0xb4
                    8'hc7: output_reg <= 8'hc6; //s(0xc7)=0xc6
                    8'hc8: output_reg <= 8'he8; //s(0xc8)=0xe8
                    8'hc9: output_reg <= 8'hdd; //s(0xc9)=0xdd
                    8'hca: output_reg <= 8'h74; //s(0xca)=0x74
                    8'hcb: output_reg <= 8'h1f; //s(0xcb)=0x1f
                    8'hcc: output_reg <= 8'h4b; //s(0xcc)=0x4b
                    8'hcd: output_reg <= 8'hbd; //s(0xcd)=0xbd
                    8'hce: output_reg <= 8'h8b; //s(0xce)=0x8b
                    8'hcf: output_reg <= 8'h8a; //s(0xcf)=0x8a
                    8'hd0: output_reg <= 8'h70; //s(0xd0)=0x70
                    8'hd1: output_reg <= 8'h3e; //s(0xd1)=0x3e
                    8'hd2: output_reg <= 8'hb5; //s(0xd2)=0xb5
                    8'hd3: output_reg <= 8'h66; //s(0xd3)=0x66
                    8'hd4: output_reg <= 8'h48; //s(0xd4)=0x48
                    8'hd5: output_reg <= 8'h03; //s(0xd5)=0x03
                    8'hd6: output_reg <= 8'hf6; //s(0xd6)=0xf6
                    8'hd7: output_reg <= 8'h0e; //s(0xd7)=0x0e
                    8'hd8: output_reg <= 8'h61; //s(0xd8)=0x61
                    8'hd9: output_reg <= 8'h35; //s(0xd9)=0x35
                    8'hda: output_reg <= 8'h57; //s(0xda)=0x57
                    8'hdb: output_reg <= 8'hb9; //s(0xdb)=0xb9
                    8'hdc: output_reg <= 8'h86; //s(0xdc)=0x86
                    8'hdd: output_reg <= 8'hc1; //s(0xdd)=0xc1
                    8'hde: output_reg <= 8'h1d; //s(0xde)=0x1d
                    8'hdf: output_reg <= 8'h9e; //s(0xdf)=0x9e
                    8'he0: output_reg <= 8'he1; //s(0xe0)=0xe1
                    8'he1: output_reg <= 8'hf8; //s(0xe1)=0xf8
                    8'he2: output_reg <= 8'h98; //s(0xe2)=0x98
                    8'he3: output_reg <= 8'h11; //s(0xe3)=0x11
                    8'he4: output_reg <= 8'h69; //s(0xe4)=0x69
                    8'he5: output_reg <= 8'hd9; //s(0xe5)=0xd9
                    8'he6: output_reg <= 8'h8e; //s(0xe6)=0x8e
                    8'he7: output_reg <= 8'h94; //s(0xe7)=0x94
                    8'he8: output_reg <= 8'h9b; //s(0xe8)=0x9b
                    8'he9: output_reg <= 8'h1e; //s(0xe9)=0x1e
                    8'hea: output_reg <= 8'h87; //s(0xea)=0x87
                    8'heb: output_reg <= 8'he9; //s(0xeb)=0xe9
                    8'hec: output_reg <= 8'hce; //s(0xec)=0xce
                    8'hed: output_reg <= 8'h55; //s(0xed)=0x55
                    8'hee: output_reg <= 8'h28; //s(0xee)=0x28
                    8'hef: output_reg <= 8'hdf; //s(0xef)=0xdf
                    8'hf0: output_reg <= 8'h8c; //s(0xf0)=0x8c
                    8'hf1: output_reg <= 8'ha1; //s(0xf1)=0xa1
                    8'hf2: output_reg <= 8'h89; //s(0xf2)=0x89
                    8'hf3: output_reg <= 8'h0d; //s(0xf3)=0x0d
                    8'hf4: output_reg <= 8'hbf; //s(0xf4)=0xbf
                    8'hf5: output_reg <= 8'he6; //s(0xf5)=0xe6
                    8'hf6: output_reg <= 8'h42; //s(0xf6)=0x42
                    8'hf7: output_reg <= 8'h68; //s(0xf7)=0x68
                    8'hf8: output_reg <= 8'h41; //s(0xf8)=0x41
                    8'hf9: output_reg <= 8'h99; //s(0xf9)=0x99
                    8'hfa: output_reg <= 8'h2d; //s(0xfa)=0x2d
                    8'hfb: output_reg <= 8'h0f; //s(0xfb)=0x0f
                    8'hfc: output_reg <= 8'hb0; //s(0xfc)=0xb0
                    8'hfd: output_reg <= 8'h54; //s(0xfd)=0x54
                    8'hfe: output_reg <= 8'hbb; //s(0xfe)=0xbb
                    default: output_reg <= 0; //should cause a noticeable error in the TB
                endcase

            end
        end
    end

endmodule
