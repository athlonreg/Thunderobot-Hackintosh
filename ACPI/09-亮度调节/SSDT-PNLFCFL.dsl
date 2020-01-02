// Adding PNLF device for IntelBacklight.kext or AppleBacklight.kext+AppleBacklightFixup.kext
// This one is specific to CFL

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "ACDT", "_PNLFCFL", 0)
{
#endif
    External (_SB.PCI0.GFX0, DeviceObj)
    // For backlight control
    Scope (_SB.PCI0.GFX0)
    {
        Device (PNLF)
        {
            Name(_ADR, Zero)
            Name(_HID, EisaId("APP0002"))
            Name(_CID, "backlight")
            Name(_UID, 19)
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
