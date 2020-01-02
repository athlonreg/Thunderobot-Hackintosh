//Disables DGPU
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "NDGP", 0)
{
#endif
    External(_SB.PCI0.PEG0.PEGP._OFF, MethodObj)
    
    Device(DGPU)
    {
        Name(_HID, "DGPU1000")
        Method(_INI)
        {
            If (_OSI ("Darwin"))
            {
                \_SB.PCI0.PEG0.PEGP._OFF ()
            }
        }
        
        Method (_STA)
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF