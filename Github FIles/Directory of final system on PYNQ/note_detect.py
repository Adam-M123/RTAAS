########################### Note detection Function ############
def note(f4):
    # Frequency 82.4 Hz
    E2 = '0'
    if ((f4[20] and f4[40] and f4[60] and f4[80]) == 1):
        E2 = '1'
    # Frequency 87.3 Hz
    F2 = '0'
    if ((f4[21] and f4[44] and f4[66] and f4[88])  == 1):
        F2 = '1'
    # Frequency 92.5 Hz
    FS2 = '0'
    if ((f4[23] and f4[46] and f4[69] and f4[92]) == 1):
        FS2 = '1'
    # Frequency 98.0 Hz
    G2 = '0'
    if ((f4[25] and f4[50] and f4[75] and f4[100]) == 1):
        G2 = '1'
    #Frequency 103.8
    GS2 = '0'
    if ((f4[26] and f4[52] and f4[78] and f4[104]) == 1):
        GS2 = '1'
    # Frequency 110.0 Hz
    A2 = '0'
    if ((f4[28] and f4[56] and f4[84] and f4[112]) == 1):
        A2 = '1'
    # Frequency 116.5 Hz
    AS2 = '0'
    if ((f4[29] and f4[58] and f4[87] and f4[116]) == 1):
        AS2 = '1'
    # Frequency 123.5 Hz
    B2 = '0'
    if ((f4[31] and f4[62] and f4[93]) == 1):
        B2 = '1'
    # Frequency 130.8 Hz
    C3 = '0'
    if ((f4[33] and f4[66] and f4[99]) == 1):
        C3 = '1'
    # Frequency 138.6 Hz
    CS3 = '0'
    if ((f4[35] and f4[70] and f4[105]) == 1):
        CS3 = '1'
    # Frequency 146.8 Hz
    D3 = '0'
    if ((f4[37] and f4[74] and f4[111]) == 1):
        D3 = '1'
    # Frequency 155.6 Hz
    DS3 = '0'
    if ((f4[39] and f4[78] and f4[117]) == 1):
        DS3 = '1'
    # Frequency 164.8 Hz
    E3 = '0'
    if ((f4[41] and f4[82] and f4[123]) == 1):
        E3 = '1'
    # Frequency 174.6 Hz
    F3 = '0'
    if ((f4[44] and f4[88] and f4[132]) == 1):
        F3 = '1'
    # Frequency 185.0 Hz
    FS3 = '0'
    if ((f4[46] and f4[92] and f4[138]) == 1):
        FS3 = '1'
    # Frequency 196.0 Hz
    G3 = '0'
    if ((f4[49] and f4[98] and f4[147]) == 1):
        G3 = '1'
    # Frequency 207.7 Hz
    GS3 = '0'
    if ((f4[52] and f4[104] and f4[156]) == 1):
        GS3 = '1'
    # Frequency 220.0 Hz
    A3 = '0'
    if ((f4[55] and f4[110] and f4[165]) == 1):
        A3 = '1'
    # Frequency 233.1 Hz
    AS3 = '0'
    if ((f4[58] and f4[116] and f4[174]) == 1):
        AS3 = '1'
    # Frequency 246.9 Hz
    B3 = '0'
    if ((f4[62] and f4[124] and f4[186]) == 1):
        B3 = '1'
    # Frequency 261.6 Hz
    C4 = '0'
    if ((f4[65] and f4[130] and f4[195]) == 1):
        C4 = '1'
    # Frequency 277.2 Hz
    CS4 = '0'
    if ((f4[69] and f4[138] and f4[207]) == 1):
        CS4 = '1'
    # Frequency 293.7 Hz
    D4 = '0'
    if ((f4[73] and f4[146] and f4[219]) == 1):
        D4 = '1'
    # Frequency 311.1 Hz
    DS4 = '0'
    if ((f4[78] and f4[156] and f4[234]) == 1):
        DS4 = '1'
    # Frequency 329.6 Hz
    E4 = '0'
    if ((f4[83] and f4[166] and f4[249]) == 1):
        E4 = '1'
    # Frequency 349.2 Hz
    F4 = '0'
    if ((f4[87] and f4[174] and f4[261]) == 1):
        F4 = '1'
    # Frequency 370.0 Hz
    FS4 = '0'
    if ((f4[93] and f4[186] and f4[279]) == 1):
        FS4 = '1'
    # Frequency 392.0 Hz
    G4 = '0'
    if ((f4[98] and f4[196] and f4[294]) == 1):
        G4 = '1'
    # Frequency 415.3 Hz
    GS4 = '0'
    if ((not(f4[52]) and f4[104] and f4[208]) == 1):
        GS4 = '1'
    # Frequency 440.0 Hz
    A4 = '0'
    if ((not(f4[55]) and f4[110] and f4[220]) == 1):
        A4 = '1'
    # Frequency 466.2 Hz
    AS4 = '0'
    if ((not(f4[59]) and f4[117] and f4[234]) == 1):
        AS4 = '1'
    # Frequency 493.9 Hz
    B4 = '0'
    if ((not(f4[62]) and f4[123] and f4[246]) == 1):
        B4 = '1'
    # Frequency 523.3 Hz
    C5 = '0'
    if ((not(f4[66]) and f4[131] and f4[262]) == 1):
        C5 = '1'
    # Frequency 554.4 Hz
    CS5 = '0'
    if ((not(f4[70]) and f4[139] and f4[278]) == 1):
        CS5 = '1'
    # Frequency 587.3 Hz
    D5 = '0'
    if ((not(f4[74]) and f4[147] and f4[294]) == 1):
        D5 = '1'
    # Frequency 622.3 Hz
    DS5 = '0'
    if ((not(f4[78]) and f4[156] and f4[312]) == 1):
        DS5 = '1'
    # Frequency 659.3 Hz
    E5 = '0'
    if ((not(f4[83]) and f4[165] and f4[330]) == 1):
        E5 = '1'
    Notes = E2 + F2 + FS2 + G2 + GS2 + A2 + AS2 + B2 + C3 + CS3 + D3 + DS3 + E3 + F3 + FS3 + G3 + GS3 + A3 + AS3 + B3 + C4 + CS4 + D4 + DS4 + E4 + F4 + FS4 + G4 + GS4 + A4 + AS4 + B4 + C5 + CS5 + D5 + DS5 + E5
    
    return Notes