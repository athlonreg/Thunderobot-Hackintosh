//
// BrightKey for Thunderobot 911 TR 6700HQ
// In config ACPI, _Q60 to XQ60
// Find:     5F 51 36 30
// Replace:  58 51 36 30
//
DefinitionBlock ("", "SSDT", 2, "hack", "BrightFN", 0x00000000)
{
    External (_SB_.GGOV, MethodObj)
    External (_SB_.GWMI, UnknownObj)
    External (_SB_.GWMI.BNUD, BuffObj)
    External (_SB_.GWMI.FNMX, BuffObj)
    External (_SB_.GWMI.OFST, BuffObj)
    External (_SB_.PCI0.GFX0.DD1F, DeviceObj)
    External (_SB_.PCI0.GFX0.DD1F.BRDN, MethodObj)
    External (_SB_.PCI0.GFX0.DD1F.BRDT, MethodObj)
    External (_SB_.PCI0.GFX0.DD1F.BRUP, MethodObj)
    External (_SB_.PCI0.GFX0.DD1F.QBCM, MethodObj)
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.BLIS, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.CBSC, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.ENTP, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.F2DA, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.FANM, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.XQ60, MethodObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (_SB_.SGOV, MethodObj)
    External (_SB_.SLPB, DeviceObj)
    External (_SB_.WMI2, DeviceObj)
    External (_SB_.FL06, FieldUnitObj)
    External (_SB_.WMI2.BROF, BuffObj)
    External (_SB_.WMI2.CAMR, BuffObj)
    External (_SB_.WMI2.FMAX, BuffObj)
    External (_SB_.WMI2.FN02, BuffObj)
    External (_SB_.WMI2.TPST, BuffObj)
    External (_SB_.WMI2.WEID, IntObj)
    External (BRST, FieldUnitObj)
    External (FANM, IntObj)
    External (OSYS, FieldUnitObj)
    External (P80H, FieldUnitObj)
    External (\CCOF, FieldUnitObj)

    Scope (\)
    {
        Name (SPMD, One)
    }

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q60, 0, Serialized)
        {
            P80H = CBSC
            If (LEqual (CBSC, 0x0F))
            {
                ^^^^WMI2.TPST = (ENTP ^ One)
                Sleep (0x32)
                ^^^^WMI2.WEID = 0x0D
                Notify (WMI2, 0x80)
            }

            If (LEqual (CBSC, One))
            {
                If (_OSI ("Darwin"))
                {
                    If ((SPMD == Zero))
                    {
                        \_SB.PCI0.LPCB.EC0.XQ60 ()
                    }
                    Else
                    {
                        Notify (SLPB, 0x80)
                    }
                }
                Else
                {
                    \_SB.PCI0.LPCB.EC0.XQ60 ()
                }
            }

            If (LEqual (CBSC, 0x04))
            {
                If (_OSI ("Darwin"))
                {
                    Notify (\_SB.PCI0.LPCB.PS2K, 0x0405)
                    Notify (\_SB.PCI0.LPCB.PS2K, 0x20)
                }
                Else
                {
                    If (LAnd (LGreater (OSYS, 0x07D0), LLess (OSYS, 0x07D6)))
                    {
                        ^^^GFX0.DD1F.QBCM (^^^GFX0.DD1F.BRDN ())
                    }
                    Else
                    {
                        Store (^^^GFX0.DD1F.BRDT (), BRST)
                        Notify (^^^GFX0.DD1F, 0x87)
                    }

                    If (LLessEqual (BRST, One))
                    {
                        Store (One, BRST)
                    }
                    Else
                    {
                        Decrement (BRST)
                    }

                    Sleep (0x64)
                    If (LLess (OSYS, 0x07DC))
                    {
                        Store (0x04, ^^^^WMI2.WEID)
                        Notify (WMI2, 0x80)
                    }
                }
            }

            If (LEqual (CBSC, 0x05))
            {
                If (_OSI ("Darwin"))
                {
                    Notify (\_SB.PCI0.LPCB.PS2K, 0x0406)
                    Notify (\_SB.PCI0.LPCB.PS2K, 0x10)
                }
                Else
                {
                    If (LAnd (LGreater (OSYS, 0x07D0), LLess (OSYS, 0x07D6)))
                    {
                        ^^^GFX0.DD1F.QBCM (^^^GFX0.DD1F.BRUP ())
                    }
                    Else
                    {
                        Store (^^^GFX0.DD1F.BRDT (), BRST)
                        Notify (^^^GFX0.DD1F, 0x86)
                    }

                    If (LGreaterEqual (BRST, 0x09))
                    {
                        Store (0x09, BRST)
                    }
                    Else
                    {
                        Increment (BRST)
                    }

                    Sleep (0x64)
                    If (LLess (OSYS, 0x07DC))
                    {
                        Store (0x05, ^^^^WMI2.WEID)
                        Notify (WMI2, 0x80)
                    }
                }
            }

            If (LEqual (CBSC, 0x10))
            {
                Store (LNot (BLIS), ^^^^WMI2.BROF)
                Sleep (0x32)
                Store (0x31, ^^^^WMI2.WEID)
                Notify (WMI2, 0x80)
            }

            If (LEqual (CBSC, 0x11))
            {
                Store (FANM, ^^^^WMI2.FMAX)
                Sleep (0x32)
                Store (0x30, ^^^^WMI2.WEID)
                Notify (GWMI, 0x80)
            }

            If (LEqual (CBSC, 0x12))
            {
                If (LEqual (F2DA, Zero))
                {
                    Store (Zero, ^^^^WMI2.FN02)
                }
                ElseIf (LEqual (F2DA, One))
                {
                    Store (0x02, ^^^^WMI2.FN02)
                }
                Else
                {
                    Store (One, ^^^^WMI2.FN02)
                }

                Sleep (0x32)
                Store (0x3A, ^^^^WMI2.WEID)
                Notify (WMI2, 0x80)
            }

            If (LEqual (CBSC, 0x18))
            {
                If (FL06)
                {
                    CCOF = Zero
                    FL06 = Zero
                }
                Else
                {
                    CCOF = One
                    FL06 = One
                }

                If (CCOF == Zero)
                {
                    Store (Zero, ^^^^WMI2.CAMR)
                }
                Else
                {
                    Store (One, ^^^^WMI2.CAMR)
                }

                Sleep (0x32)
                Store (0x39, ^^^^WMI2.WEID)
                Notify (WMI2, 0x80)
            }
        }
    }
}

