// BrightKey for Thunderobot 911 Air2 9750h
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
    External (_SB_.WMIA, UnknownObj)
    External (_SB_.WMIA.BROF, BuffObj)
    External (_SB_.WMIA.CAMR, BuffObj)
    External (_SB_.WMIA.FMAX, BuffObj)
    External (_SB_.WMIA.FN02, BuffObj)
    External (_SB_.WMIA.TPST, BuffObj)
    External (_SB_.WMIA.WEID, IntObj)
    External (BRST, FieldUnitObj)
    External (FANM, IntObj)
    External (OSYS, FieldUnitObj)
    External (P80B, FieldUnitObj)

    Scope (\)
    {
        Name (SPMD, One)
    }

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q60, 0, Serialized)
        {
            Store (0x60, P80B)
            If (LEqual (CBSC, 0x0F))
            {
                XOr (^^^^WMIA.TPST, One, ^^^^WMIA.TPST)
                Sleep (0x32)
                Store (0x0D, ^^^^WMIA.WEID)
                Notify (WMIA, 0x80)
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
                        Store (0x02, ^^^^GWMI.OFST)
                        Store (Zero, ^^^^GWMI.BNUD)
                        Notify (GWMI, 0x80)
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
                        Store (0x04, ^^^^WMIA.WEID)
                        Notify (WMIA, 0x80)
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
                        Store (0x02, ^^^^GWMI.OFST)
                        Store (One, ^^^^GWMI.BNUD)
                        Notify (GWMI, 0x80)
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
                        Store (0x05, ^^^^WMIA.WEID)
                        Notify (WMIA, 0x80)
                    }
                }
            }

            If (LEqual (CBSC, 0x10))
            {
                Store (LNot (BLIS), ^^^^WMIA.BROF)
                Sleep (0x32)
                Store (0x31, ^^^^WMIA.WEID)
                Notify (WMIA, 0x80)
            }

            If (LEqual (CBSC, 0x11))
            {
                Store (FANM, ^^^^WMIA.FMAX)
                Sleep (0x32)
                Store (0x30, ^^^^WMIA.WEID)
                Notify (WMIA, 0x80)
                Store (0x03, ^^^^GWMI.OFST)
                Switch (FANM)
                {
                    Case (Zero)
                    {
                        Store (Zero, ^^^^GWMI.FNMX)
                    }
                    Case (One)
                    {
                        Store (One, ^^^^GWMI.FNMX)
                    }

                }

                Notify (GWMI, 0x80)
            }

            If (LEqual (CBSC, 0x12))
            {
                If (LEqual (F2DA, Zero))
                {
                    Store (Zero, ^^^^WMIA.FN02)
                }
                ElseIf (LEqual (F2DA, One))
                {
                    Store (0x02, ^^^^WMIA.FN02)
                }
                Else
                {
                    Store (One, ^^^^WMIA.FN02)
                }

                Sleep (0x32)
                Store (0x3A, ^^^^WMIA.WEID)
                Notify (WMIA, 0x80)
            }

            If (LEqual (CBSC, 0x18))
            {
                If (LEqual (GGOV (0x0303000A), One))
                {
                    SGOV (0x0303000A, Zero)
                }
                Else
                {
                    SGOV (0x0303000A, One)
                }

                If (LEqual (GGOV (0x0303000A), Zero))
                {
                    Store (Zero, ^^^^WMIA.CAMR)
                }
                Else
                {
                    Store (One, ^^^^WMIA.CAMR)
                }

                Sleep (0x32)
                Store (0x39, ^^^^WMIA.WEID)
                Notify (WMIA, 0x80)
            }
        }
    }
}

