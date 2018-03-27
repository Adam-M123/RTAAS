from pynq import MMIO
def gpio_setup(transfer_XADC, transfer_XFFT, set_FFT):
    gpio = MMIO(0x41200000)          # GPIO for FFT configuration
    gpio.write(0, set_FFT) # / 16
    gpio1 = MMIO(0x41210000)         # GPIO specifying size of XADC buffer
    gpio1.write(0, int(transfer_XADC/2)) # tlast block (Half of ADC transfer size)
    gpio2 = MMIO(0x41220000)         # GPIO Specifying size of FFT output buffer  
    gpio2.write(0, int(transfer_XFFT/4)) # tlast block (Quarter of FFt transfer size)