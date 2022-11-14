import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles
import codecs
import string

ascii_alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
rot_13_alphabet = codecs.encode(ascii_alphabet, "rot_13")
ascii_int = [ord(x) for x in ascii_alphabet]
rot13_int = [ord(x) for x in rot_13_alphabet]
ascii_low = [x & 0x0F for x in ascii_int]
ascii_high = [x >> 4 for x in ascii_int]

@cocotb.test()
async def test_in_sequence(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    
    dut._log.info("reset")
    # reset all init to 0
    dut.rst.value = 1
    dut.ctl.value = 0
    dut.data_in.value = 0
    await ClockCycles(dut.clk, 10)
    
    dut.rst.value = 0
    dut._log.info("check if ctl=00 reads 0x0f when clock advances")
    await ClockCycles(dut.clk, 10)
    assert int(dut.data_out.value) == 0x0F

    dut._log.info("check if ctl=01 reads 0xf0 when clock advances")
    dut.ctl.value = 1
    await ClockCycles(dut.clk, 10)
    assert int(dut.data_out.value) == 0xF0

    dut._log.info("check if ctl=10 reads 0x00 when clock advances")
    dut.ctl.value = 2
    await ClockCycles(dut.clk, 10)
    assert int(dut.data_out.value) == 0x00

    dut._log.info("check if ctl=11 reads 0xff when clock advances")
    dut.ctl.value = 3
    await ClockCycles(dut.clk, 10)
    assert int(dut.data_out.value) == 0x00

@cocotb.test()
async def test_low_nibble_output(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    
    dut._log.info("reset")
    # reset all init to 0
    dut.rst.value = 1
    dut.ctl.value = 0
    dut.data_in.value = 0
    await ClockCycles(dut.clk, 10)
    
    dut.rst.value = 0
    dut._log.info(" check if ctl=00 reads 0x0f when clock advances")
    await ClockCycles(dut.clk, 10)
    assert int(dut.data_out.value) == 0x0F

@cocotb.test()
async def test_low_nibble_output_tight(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    
    dut._log.info("reset")
    # reset all init to 0
    dut.rst.value = 1
    dut.ctl.value = 0
    dut.data_in.value = 0
    await ClockCycles(dut.clk, 10)
    
    dut.rst.value = 0
    dut._log.info(" check if ctl=00 reads 0x0f when clock advances")
    await ClockCycles(dut.clk, 2)
    assert int(dut.data_out.value) == 0x0F

@cocotb.test()
async def test_high_nibble_output(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    
    dut._log.info("reset")
    # reset all init to 0
    dut.rst.value = 1
    dut.ctl.value = 0
    dut.data_in.value = 0
    await ClockCycles(dut.clk, 10)
    
    dut.rst.value = 0
    dut._log.info("check if ctl=01 reads 0xf0 when clock advances")
    dut.ctl.value = 1
    await ClockCycles(dut.clk, 10)
    assert int(dut.data_out.value) == 0xF0

@cocotb.test()
async def test_reset_data_out(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    
    dut._log.info("reset")
    # reset all init to 0
    dut.rst.value = 1
    dut.ctl.value = 0
    dut.data_in.value = 0
    await ClockCycles(dut.clk, 10)
    
    dut.rst.value = 0
    dut._log.info("after reset, check if io_out reads 0x00")
    await ClockCycles(dut.clk, 1)
    assert int(dut.data_out.value) == 0x00

@cocotb.test()
async def test_reset_data_out_stability(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    
    dut._log.info("reset")
    # reset all init to 0
    dut.rst.value = 1
    dut.ctl.value = 2
    dut.data_in.value = 0
    await ClockCycles(dut.clk, 10)

    dut.rst.value = 0
    dut._log.info("after reset, check if io_out reads 0x00")
    await ClockCycles(dut.clk, 1)
    assert int(dut.data_out.value) == 0x00
    await ClockCycles(dut.clk, 1)
    assert int(dut.data_out.value) == 0x00

@cocotb.test()
async def test_rot13_reset_each(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    
    dut._log.info("check all alphabet permutations, resetting each time")
    for idx, val in enumerate(ascii_alphabet):
        # reset DUT
        dut._log.info("reset sequence {}".format(idx))
        # reset all init to 0
        dut.rst.value = 1
        dut.ctl.value = 0
        dut.data_in.value = 0
        await ClockCycles(dut.clk, 2)
        assert int(dut.data_out.value) == 0x00
        dut.rst.value = 0
        await ClockCycles(dut.clk, 1) # wait 1 clock and check for still 0
        assert int(dut.data_out.value) == 0x00

        # load nibble_low
        dut._log.info(f" iter={idx}, load nibble low with {ascii_low[idx]}")
        dut.ctl.value = 0
        dut.data_in.value = ascii_low[idx]
        await ClockCycles(dut.clk, 2)
        assert int(dut.data_out.value) == 0x0F

        # load nibble_high
        dut._log.info(f" iter={idx}, load nibble high with {ascii_high[idx]}")
        dut.ctl.value = 1
        dut.data_in.value = ascii_high[idx]
        await ClockCycles(dut.clk, 2)
        assert int(dut.data_out.value) == 0xF0

        # set control signal
        dut.ctl.value = 2
        await ClockCycles(dut.clk, 2)
        # check result
        dut._log.info(f"checking if {ascii_alphabet[idx]},int={ascii_int[idx]} returns {rot_13_alphabet[idx]},int={rot13_int[idx]}")
        assert int(dut.data_out.value) == rot13_int[idx]

@cocotb.test()
async def test_rot13_sequence(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())

    # reset DUT
    dut._log.info("reset sequence")
    # reset all init to 0
    dut.rst.value = 1
    dut.ctl.value = 0
    dut.data_in.value = 0
    await ClockCycles(dut.clk, 2)
    assert int(dut.data_out.value) == 0x00
    dut.rst.value = 0
    await ClockCycles(dut.clk, 1) # wait 1 clock and check for still 0
    assert int(dut.data_out.value) == 0x00
    
    dut._log.info("check all alphabet permutations, with no resets")
    for idx, val in enumerate(ascii_alphabet):
        # load nibble_low
        dut._log.info(f" iter={idx}, load nibble low with {ascii_low[idx]}")
        dut.ctl.value = 0
        dut.data_in.value = ascii_low[idx]
        await ClockCycles(dut.clk, 2)
        assert int(dut.data_out.value) == 0x0F

        # load nibble_high
        dut._log.info(f" iter={idx}, load nibble high with {ascii_high[idx]}")
        dut.ctl.value = 1
        dut.data_in.value = ascii_high[idx]
        await ClockCycles(dut.clk, 2)
        assert int(dut.data_out.value) == 0xF0

        # set control signal
        dut.ctl.value = 2
        await ClockCycles(dut.clk, 2)
        # check result
        dut._log.info(f"checking if {ascii_alphabet[idx]},int={ascii_int[idx]} returns {rot_13_alphabet[idx]},int={rot13_int[idx]}")
        assert int(dut.data_out.value) == rot13_int[idx]

@cocotb.test()
async def test_check_rot13_passthrough(dut):
    # only ASCII alphabet characters should be ROT13'd
    # every other ascii symbol should remain the same
    ascii_alphabet = string.printable
    rot_13_alphabet = codecs.encode(ascii_alphabet, "rot_13")
    ascii_int = [ord(x) for x in ascii_alphabet]
    rot13_int = [ord(x) for x in rot_13_alphabet]
    ascii_low = [x & 0x0F for x in ascii_int]
    ascii_high = [x >> 4 for x in ascii_int]
    # variable shadowing is intentional
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())

    # reset DUT
    dut._log.info("reset sequence")
    # reset all init to 0
    dut.rst.value = 1
    dut.ctl.value = 0
    dut.data_in.value = 0
    await ClockCycles(dut.clk, 2)
    assert int(dut.data_out.value) == 0x00
    dut.rst.value = 0
    await ClockCycles(dut.clk, 1) # wait 1 clock and check for still 0
    assert int(dut.data_out.value) == 0x00
    
    dut._log.info("check all sbox permutations, resetting each time")
    for idx, val in enumerate(ascii_alphabet):
        # load nibble_low
        dut._log.info(f" iter={idx}, load nibble low with {ascii_low[idx]}")
        dut.ctl.value = 0
        dut.data_in.value = ascii_low[idx]
        await ClockCycles(dut.clk, 2)
        assert int(dut.data_out.value) == 0x0F

        # load nibble_high
        dut._log.info(f" iter={idx}, load nibble high with {ascii_high[idx]}")
        dut.ctl.value = 1
        dut.data_in.value = ascii_high[idx]
        await ClockCycles(dut.clk, 2)
        assert int(dut.data_out.value) == 0xF0

        # set control signal
        dut.ctl.value = 2
        await ClockCycles(dut.clk, 2)
        # check result
        dut._log.info(f"checking if {ascii_alphabet[idx]},int={ascii_int[idx]} returns {rot_13_alphabet[idx]},int={rot13_int[idx]}")
        assert int(dut.data_out.value) == rot13_int[idx]