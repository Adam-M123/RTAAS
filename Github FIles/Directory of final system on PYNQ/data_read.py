import numpy as np
############################ Function to read negative numbers
def twos_comp(val, bits):
    """compute the 2's complement of int value val"""
    if (val & (1 << (bits - 1))) != 0: # if sign bit is set e.g., 8bit: 128-255
        val = val - (1 << bits)        # compute negative value
    return val
########################### Function to convert tdata to complex notation
def comp(val):
    maskRE = 0b1111111111111111
    maskIM = 0b11111111111111110000000000000000
    real = twos_comp(maskRE & val, 16)
    img = twos_comp((maskIM & val) >> 16, 16)
    mag = np.sqrt((real*real) + (img*img))
    return mag
######################### Function to read ADC data
def xadc_val(x):
    mask = 0b1111111111111111
    y = mask & x
    return y