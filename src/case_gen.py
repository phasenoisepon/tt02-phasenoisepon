#!/usr/bin/python3
import codecs
import string
# ascii_alphabet = string.printable
ascii_alphabet = "".join([chr(i) for i in range(128)])
rot_13_alphabet = codecs.encode(ascii_alphabet, "rot_13")

### Example format of case block
#
#    case ({nibble_high,nibble_low})
#        8'h00: output_reg <= 8'h63; //s(0x00)=0x63
#        default: output_reg <= 0; //should cause a noticeable error in the TB
#    endcase
#

format_str = "8'h{1}{2}: output_reg <= 8'h{0}; //rot13(0x{1}{2})=0x{0}, {4}->{3}"

for idx, letter in enumerate(ascii_alphabet):
    ascii_letter = ascii_alphabet[idx]
    ascii_letter_int = ord(ascii_letter)
    rot13_letter = rot_13_alphabet[idx]
    rot_13_letter_int = ord(rot13_letter)
    
    high_nibble, low_nibble = ascii_letter_int >> 4, ascii_letter_int & 0x0F
    print(format_str.format("{0:0{1}x}".format(rot_13_letter_int,2),hex(high_nibble)[2:],hex(low_nibble)[2:],ascii(rot13_letter), ascii(ascii_letter)))
    