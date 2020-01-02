/*
 * In ACPI -> Patch:
 * Comment: I2C:_STA to XSTA in TPD0
 * Find:    0A5F5354 41007042 44
 * Replace: 0A585354 41007042 44
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "I2Cpatch", 0x00000000)
{
    External (_SB_.PCI0.I2C1.TPD0, DeviceObj)
    External (_SB_.PCI0.I2C1.TPD0.XSTA, MethodObj)

    Scope (_SB.PCI0.I2C1.TPD0)
    {
        Method (_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (\_SB.PCI0.I2C1.TPD0.XSTA ())
            }
        }
    }
}