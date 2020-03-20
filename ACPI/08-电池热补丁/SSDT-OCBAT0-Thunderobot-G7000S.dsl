//// battery
// In config ACPI, UPBI to XPBI
// Find:     5550424900
// Replace:  5850424900
//
// In config ACPI, UPBS to XPBS
// Find:     5550425300
// Replace:  5850425300
//
DefinitionBlock ("", "SSDT", 2, "OCLT", "BAT0", 0)
{
    External (_SB.AC.ACFG, IntObj)
    External (_SB.BAT0, DeviceObj)
    External (_SB.BAT0.BFCC, IntObj)
    External (_SB.BAT0.IVBI, MethodObj)
    External (_SB.BAT0.IVBS, MethodObj)
    External (_SB.BAT0.PBIF, PkgObj)
    External (_SB.BAT0.PBST, PkgObj)
    External (_SB.BAT0.XPBI, MethodObj)
    External (_SB.BAT0.XPBS, MethodObj)
    External (_SB.PCI0.LPCB.EC, DeviceObj)
    External (_SB.PCI0.LPCB.EC.BAT0, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.BST0, FieldUnitObj)

    Method (B1B4, 4, NotSerialized)
    {
        Local0 = (Arg2 | (Arg3 << 0x08))
        Local0 = (Arg1 | (Local0 << 0x08))
        Local0 = (Arg0 | (Local0 << 0x08))
        Return (Local0)
    }

    Scope (_SB.PCI0.LPCB.EC)
    {
        OperationRegion (ERAM, SystemMemory, 0xFF500100, 0x0400)
        Field (ERAM, ByteAcc, NoLock, Preserve)
        {
            Offset (0x16), 
            BDC1,8,BDC2,8,BDC3,8,BDC4,8, //BDC0,   32, 
            BFC1,8,BFC2,8,BFC3,8,BFC4,8, //BFC0,   32, 
            Offset (0x22), 
            BDV1,8,BDV2,8,BDV3,8,BDV4,8, //BDV0,   32, 
            BST1,8,BST2,8,BST3,8,BST4,8, //BST0,   32, 
            BPR1,8,BPR2,8,BPR3,8,BPR4,8, //BPR0,   32, 
            BRC1,8,BRC2,8,BRC3,8,BRC4,8, //BRC0,   32, 
            BPV1,8,BPV2,8,BPV3,8,BPV4,8, //BPV0,   32, 
            Offset (0x3A), 
            BCW1,8,BCW2,8,BCW3,8,BCW4,8, //BCW0,   32, 
            BCL1,8,BCL2,8,BCL3,8,BCL4,8  //BCL0,   32, 
        }
    }

    Scope (_SB.BAT0)
    {
        Method (UPBI, 0, NotSerialized)
        {
            If (_OSI ("Dariwin"))
            {
                If (^^PCI0.LPCB.EC.BAT0)
                {
                    Local0 = (B1B4 (^^PCI0.LPCB.EC.BDC1, ^^PCI0.LPCB.EC.BDC2, ^^PCI0.LPCB.EC.BDC3, ^^PCI0.LPCB.EC.BDC4) & 0xFFFF)
                    PBIF [One] = Local0
                    Local0 = (B1B4 (^^PCI0.LPCB.EC.BFC1, ^^PCI0.LPCB.EC.BFC2, ^^PCI0.LPCB.EC.BFC3, ^^PCI0.LPCB.EC.BFC4) & 0xFFFF)
                    PBIF [0x02] = Local0
                    BFCC = Local0
                    Local0 = (B1B4 (^^PCI0.LPCB.EC.BDV1, ^^PCI0.LPCB.EC.BDV2, ^^PCI0.LPCB.EC.BDV3, ^^PCI0.LPCB.EC.BDV4) & 0xFFFF)
                    PBIF [0x04] = Local0
                    Local0 = (B1B4 (^^PCI0.LPCB.EC.BCW1, ^^PCI0.LPCB.EC.BCW2, ^^PCI0.LPCB.EC.BCW3, ^^PCI0.LPCB.EC.BCW4) & 0xFFFF)
                    PBIF [0x05] = Local0
                    Local0 = (B1B4 (^^PCI0.LPCB.EC.BCL1, ^^PCI0.LPCB.EC.BCL2, ^^PCI0.LPCB.EC.BCL3, ^^PCI0.LPCB.EC.BCL4) & 0xFFFF)
                    PBIF [0x06] = Local0
                    PBIF [0x09] = "BAT"
                    PBIF [0x0A] = "0001"
                    PBIF [0x0B] = "LION"
                    PBIF [0x0C] = "Notebook"
                }
                Else
                {
                    \_SB.BAT0.IVBI ()
                }
            }
            Else
            {
                XPBI ()
            }
        }

        Method (UPBS, 0, NotSerialized)
        {
            If (_OSI ("Dariwin"))
            {
                If (^^PCI0.LPCB.EC.BAT0)
                {
                    Local0 = Zero
                    Local1 = Zero
                    If (^^AC.ACFG)
                    {
                        If (((^^PCI0.LPCB.EC.BST0 & 0x02) == 0x02))
                        {
                            Local0 |= 0x02
                            Local1 = (B1B4 (^^PCI0.LPCB.EC.BPR1, ^^PCI0.LPCB.EC.BPR2, ^^PCI0.LPCB.EC.BPR3, ^^PCI0.LPCB.EC.BPR4) & 0xFFFF)
                        }
                    }
                    Else
                    {
                        Local0 |= One
                        Local1 = (B1B4 (^^PCI0.LPCB.EC.BPR1, ^^PCI0.LPCB.EC.BPR2, ^^PCI0.LPCB.EC.BPR3, ^^PCI0.LPCB.EC.BPR4) & 0xFFFF)
                    }

                    Local7 = (Local1 & 0x8000)
                    If ((Local7 == 0x8000))
                    {
                        Local1 ^= 0xFFFF
                    }

                    Local2 = (B1B4 (^^PCI0.LPCB.EC.BRC1, ^^PCI0.LPCB.EC.BRC2, ^^PCI0.LPCB.EC.BRC3, ^^PCI0.LPCB.EC.BRC4) & 0xFFFF)
                    Local3 = (B1B4 (^^PCI0.LPCB.EC.BPV1, ^^PCI0.LPCB.EC.BPV2, ^^PCI0.LPCB.EC.BPV3, ^^PCI0.LPCB.EC.BPV4) & 0xFFFF)
                    PBST [Zero] = Local0
                    PBST [One] = Local1
                    PBST [0x02] = Local2
                    PBST [0x03] = Local3
                    If ((BFCC != B1B4 (^^PCI0.LPCB.EC.BFC1, ^^PCI0.LPCB.EC.BFC2, ^^PCI0.LPCB.EC.BFC3, ^^PCI0.LPCB.EC.BFC4)))
                    {
                        Notify (BAT0, 0x81)
                    }
                }
                Else
                {
                    \_SB.BAT0.IVBS ()
                }
            }
            Else
            {
                XPBS ()
            }
        }
    }
}

