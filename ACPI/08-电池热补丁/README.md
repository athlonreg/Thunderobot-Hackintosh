### 获取大于 16 的字节

> DSDT 中搜索 EmbeddedControl

![BAT0-01](https://raw.githubusercontent.com/athlonreg/Thunderobot-Hackintosh/master/imgs/BAT0-01.png)

将Field (ERAM, ByteAcc, NoLock, Preserve)后花括号内的大于 16 位的字节连同其前面的 Offset 记录下来，比如

```
Offset (0x70), 
DSCP,   16, 
LACP,   16, 
DSVG,   16, 
Offset (0x77), 
BANA,   64, 
Offset (0x82), 
MBST,   8, 
MCUR,   16, 
MBRM,   16, 
MBCV,   16, 
LKBR,   8, 
LKBG,   8, 
LKBB,   8, 
Offset (0xCA), 
FN1R,   16, 
FN2R,   16,
Offset (0xFA), 
VERN,   32
```

### 获取需要重写的方法 

挨个查找搜索出的大于 16 的字节，查看其是否在`BAT0`设备被调用，如图所示可以看出`DSCP`在方法`UPBI`方法中被调用

![BAT0-02](https://raw.github.com/athlonreg/Thunderobot-Hackintosh/master/imgs/BAT0-02.png)

按照此方法确定出所有`BAT0`下调用到的方法，整理如下

```
_SB.BAT0.UPBI
_SB.BAT0.UPBS
_SB.BAT0.IVBI
```

没有被`BAT0`下设备调用到的字节可以直接删掉，小于等于 8 的将字符串改成空，整理好如下

```
Offset (0x70), 
DSCP,   16, 
LACP,   16, 
DSVG,   16, 
Offset (0x77), 
BANA,   64, 
Offset (0x82), 
,   8, 
MCUR,   16, 
MBRM,   16, 
MBCV,   16, 

_SB.BAT0.UPBI
_SB.BAT0.UPBS
_SB.BAT0.IVBI
```

拆分后，如下

```
Offset (0x70), 
SCP0,8,SCP1,8, //DSCP,   16, 
ACP0,8,ACP1,8, //LACP,   16, 
SVG0,8,SVG1,8, //DSVG,   16,
Offset (0x77), 
//BANA,   64, Offset (0x77) ,RECB(0x77,64)

Offset (0x82), 
    ,8,
CUR0,8,CUR1,8, //MCUR,   16, 
BRM0,8,BRM1,8, //MBRM,   16, 
BCV0,8,BCV1,8, //MBCV,   16,  
```

### 编写热补丁

```
Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (RE1B, 1, NotSerialized)
        {
            OperationRegion(ERAM, EmbeddedControl, Arg0, 1)
            Field(ERAM, ByteAcc, NoLock, Preserve) { BYTE, 8 }
            Return(BYTE)
        }
        Method (RECB, 2, Serialized)
        {
            ShiftRight(Arg1, 3, Arg1)
            Name(TEMP, Buffer(Arg1) { })
            Add(Arg0, Arg1, Arg1)
            Store(0, Local0)
            While (LLess(Arg0, Arg1))
            {
                Store(RE1B(Arg0), Index(TEMP, Local0))
                Increment(Arg0)
                Increment(Local0)
            }
            Return(TEMP)
        }
        OperationRegion (ERM2, EmbeddedControl, Zero, 0xFF)
        Field (ERM2, ByteAcc, NoLock, Preserve)
        {
                Offset (0x70), 
                SCP0,8,SCP1,8, //DSCP,   16, 
                ACP0,8,ACP1,8, //LACP,   16, 
                SVG0,8,SVG1,8, //DSVG,   16,
                Offset (0x77), 
                //BANA,   64, Offset (0x77) ,RECB(0x77,64)

                Offset (0x82), 
                    ,8,
                CUR0,8,CUR1,8, //MCUR,   16, 
                BRM0,8,BRM1,8, //MBRM,   16, 
                BCV0,8,BCV1,8, //MBCV,   16,  
        }
    }
```

其中`OperationRegion`后面的部分就是前面整理出来的，`ERM2`不可与 DSDT 中的重名

将要重写的方法从 DSDT 中全部粘贴过来，注意 Scope 域

```
Scope (_SB.BAT0)
    {
        Method (UPBI, 0, NotSerialized)
            {
                Acquire (BATM, 0xFFFF)
                PBIF [One] = ^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.DSCP))
                PBIF [0x02] = ^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.LACP))
                PBIF [0x04] = ^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.DSVG))
                PBIF [0x05] = (^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.DSCP)) / 0x0A)
                PBIF [0x06] = (^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.DSCP)) / 0x64)
                PBIF [0x09] = "MWL32b"
                If ((^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.DSCP)) < 0x1770))
                {
                    PBIF [0x09] = "MWL32b"
                }

                If ((^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.DSCP)) < 0x0BB8))
                {
                    PBIF [0x09] = "MWL31b"
                }

                Release (BATM)
            }

            Method (UPBS, 0, NotSerialized)
            {
                If ((^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.MBRM)) == Zero))
                {
                    BTUR = One
                }
                ElseIf ((BTUR == One))
                {
                    Notify (BAT0, 0x81) // Information Change
                    Notify (BAT0, 0x80) // Status Change
                    BTUR = Zero
                }

                Local5 = ^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.MCUR))
                PBST [One] = POSW (Local5)
                Local5 = ^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.MBRM))
                If ((^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.BACR)) == One))
                {
                    Local5 = ((^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.DSCP)) / 0x32) + ^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.MBRM)))
                }

                Local5 = ^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.MBRM))
                If (!(Local5 & 0x8000))
                {
                    If ((Local5 != DerefOf (PBST [0x02])))
                    {
                        PBST [0x02] = Local5
                    }
                }

                PBST [0x03] = ^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.MBCV))
                PBST [Zero] = ^^PCI0.LPCB.EC0.ECRD (RefOf (^^PCI0.LPCB.EC0.MBST))
            }

            Method (IVBI, 0, NotSerialized)
            {
                PBIF [One] = 0xFFFFFFFF
                PBIF [0x02] = 0xFFFFFFFF
                PBIF [0x04] = 0xFFFFFFFF
                PBIF [0x09] = "Bad"
                PBIF [0x0A] = "Bad"
                PBIF [0x0B] = "Bad"
                PBIF [0x0C] = "Bad"
                ^^PCI0.LPCB.EC0.ECWT (Zero, RefOf (^^PCI0.LPCB.EC0.BANA))
            }
    }
```

将拆分后的替换，如`^^PCI0.LPCB.EC0.DSCP`替换为`B1B2 (^^PCI0.LPCB.EC0.SCP0, ^^PCI0.LPCB.EC0.SCP1)`，`^^PCI0.LPCB.EC0.BANA`替换为`^^PCI0.LPCB.EC0.RECB (0x77, 64)`

```
Scope (_SB.BAT0)
    {
        Method (UPBI, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Acquire (BATM, 0xFFFF)
                PBIF [One] = B1B2 (^^PCI0.LPCB.EC0.SCP0, ^^PCI0.LPCB.EC0.SCP1)
                PBIF [0x02] = B1B2 (^^PCI0.LPCB.EC0.ACP0, ^^PCI0.LPCB.EC0.ACP1)
                PBIF [0x04] = B1B2 (^^PCI0.LPCB.EC0.SVG0, ^^PCI0.LPCB.EC0.SVG1)
                PBIF [0x05] = (B1B2 (^^PCI0.LPCB.EC0.SCP0, ^^PCI0.LPCB.EC0.SCP1)/0x0A)
                PBIF [0x06] = (B1B2 (^^PCI0.LPCB.EC0.SCP0, ^^PCI0.LPCB.EC0.SCP1)/0x64)
                PBIF [0x09] = "MWL32b"
                If ((B1B2 (^^PCI0.LPCB.EC0.SCP0, ^^PCI0.LPCB.EC0.SCP1) < 0x1770))
                {
                    PBIF [0x09] = "MWL32b"
                }

                If ((B1B2 (^^PCI0.LPCB.EC0.SCP0, ^^PCI0.LPCB.EC0.SCP1) < 0x0BB8))
                {
                    PBIF [0x09] = "MWL31b"
                }

                Release (BATM)
            }
            Else
            {
                \_SB.BAT0.XPBI()
            }
        }
            
        Method (UPBS, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If ((B1B2 (^^PCI0.LPCB.EC0.BRM0, ^^PCI0.LPCB.EC0.BRM1) == Zero))
                {
                    BTUR = One
                }
                ElseIf ((BTUR == One))
                {
                    Notify (BAT0, 0x81) // Information Change
                    Notify (BAT0, 0x80) // Status Change
                    BTUR = Zero
                }

                Local5 = B1B2 (^^PCI0.LPCB.EC0.CUR0, ^^PCI0.LPCB.EC0.CUR1)
                PBST [One] = POSW (Local5)
                Local5 = B1B2 (^^PCI0.LPCB.EC0.BRM0, ^^PCI0.LPCB.EC0.BRM1)
                If ((^^PCI0.LPCB.EC0.BACR == One))
                {
                    Local5 = ((B1B2 (^^PCI0.LPCB.EC0.SCP0, ^^PCI0.LPCB.EC0.SCP1) / 0x32) + 
                        B1B2 (^^PCI0.LPCB.EC0.BRM0, ^^PCI0.LPCB.EC0.BRM1))
                }

                Local5 = B1B2 (^^PCI0.LPCB.EC0.BRM0, ^^PCI0.LPCB.EC0.BRM1)
                If (!(Local5 & 0x8000))
                {
                    If ((Local5 != DerefOf (PBST [0x02])))
                    {
                        PBST [0x02] = Local5
                    }
                }

                PBST [0x03] = B1B2 (^^PCI0.LPCB.EC0.BCV0, ^^PCI0.LPCB.EC0.BCV1)
                PBST [Zero] = ^^PCI0.LPCB.EC0.MBST
            }
            Else
            {
                \_SB.BAT0.XPBS()
            }
        }
            
        Method (IVBI, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                PBIF [One] = 0xFFFFFFFF
                PBIF [0x02] = 0xFFFFFFFF
                PBIF [0x04] = 0xFFFFFFFF
                PBIF [0x09] = "Bad"
                PBIF [0x0A] = "Bad"
                PBIF [0x0B] = "Bad"
                PBIF [0x0C] = "Bad"
                ^^PCI0.LPCB.EC0.ECWT (Zero, ^^PCI0.LPCB.EC0.RECB (0x77, 64))
            }
            Else
            {
                \_SB.BAT0.XVBI()
            }
        }
    }
```

之后修复错误保存就可以了。