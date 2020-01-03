// 
// In config ACPI, _Q11 to XQ11
// Find:     5F 51 31 31
// Replace:  58 51 31 31

// In config ACPI, _Q12 to XQ12
// Find:     5F 51 31 32
// Replace:  58 51 31 32
// 
DefinitionBlock ("", "SSDT", 2, "ACDT", "BrightFN", 0x00000000)
{
    External (_SB_.PCI0.LPCB.EC, DeviceObj)
    External (_SB_.PCI0.LPCB.EC.XQ11, MethodObj)
    External (_SB_.PCI0.LPCB.EC.XQ12, MethodObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)

    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q11, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Notify (\_SB.PCI0.LPCB.PS2K, 0x0405)
                Notify (\_SB.PCI0.LPCB.PS2K, 0x20)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ11 ()
            }
        }

        Method (_Q12, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Notify (\_SB.PCI0.LPCB.PS2K, 0x0406)
                Notify (\_SB.PCI0.LPCB.PS2K, 0x10)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ12 ()
            }
        }
    }
}

