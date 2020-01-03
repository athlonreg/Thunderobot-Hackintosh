## 雷神黑苹果套件

本仓库是针对雷神本子的特点整理出的一套方法，欢迎`PR`

#### 热补丁

> 通用型

```
SSDT-ALS0		-	亮度保存补丁
SSDT-AWAC		-	300 系需要
SSDT-DMAC		-	缺失部件(从目前接触到的雷神来看，DSDT 均没有此部件，可以添加)
SSDT-EC			-	USB 电源(从目前接触到的雷神的 EC 名称均为 EC0，10.15以上需要仿冒)
SSDT-MCHC		-	缺失部件(从目前接触到的雷神来看，DSDT 均没有此部件，可以添加)
SSDT-MEM2		-	缺失部件(从目前接触到的雷神来看，DSDT 均没有此部件，可以添加)
SSDT-PMCR		-	缺失部件(从目前接触到的雷神来看，DSDT 均没有此部件，六代以上可以添加)
SSDT-PPMC		-	缺失部件(从目前接触到的雷神来看，DSDT 均没有此部件，六代以上可以添加)
SSDT-SBUS		-	缺失部件(从目前接触到的雷神来看，DSDT 的 SMBUS 名称均为 SBUS，不存在 SMBU，可以添加)
SSDT-XSPI		-	缺失部件(从目前接触到的雷神来看，DSDT 均没有此部件，九代以上可以添加)
```

> 定制型

```
SSDT-BKey		-	亮度快捷键补丁(从目前接触到的雷神来看，亮度快捷键多数在 Q60 下(有的存在于 _Q11 和 _Q12 下)，具体内容按照模板以 DSDT 为基准修改)
SSDT-HRTF		-	声卡中断号修复(以 DSDT 中的 HPET、RTC、TIMR 内容为基准进行定制)
SSDT-OC-BAT0		-	电池热补丁(以 DSDT 中的 Embed 部分内容为基准进行定制)
SSDT-OCGPI0-GPHD	-	启用 GPI0 中断(以 DSDT 中的 Device (GPI0)  部分内容为基准进行定制)( I2C 触摸板需要)
SSDT-PLUG-_SB.PR00	-	注入 X86 (以 DSDT 中的 Processor  部分内容为基准进行定制)
SSDT-PNLF-CFL		-	亮度调节热补丁(以 CPU 型号为基准进行定制)
SSDT-TPD0		-	启用 TPD0 设备(以 DSDT 中的 Device (TPD0)  部分内容所在路径为基准进行定制)( I2C 触摸板需要，此路径可以通过 Windows 下设备管理器查看 I2C HID 设备的设备路径来确定)
SSDT-UIAC		-	USB 接口定制(利用 USBInjectALL + 端口解除补丁进入系统后在 Hackintool 去掉不用的接口导出使用)
```

**以上补丁中`缺失部件`均为可选项，根据后面的说明确定哪些需要**

#### 驱动

```
AppleALC		-	声卡驱动
HoRNDIS			-	USB 网络共享驱动
Lilu			-	Lilu 驱动
NoTouchID		-	禁用 TouchID 检测驱动( MacBookPro15 以上的机型需要)
RealtekRTL8111		-	以太网卡驱动(以自己笔记本的以太网卡型号为准)
SMCBatteryManager	-	电池显示驱动
SMCLightSensor		-	光传感器驱动
SMCProcessor		-	处理器传感器驱动
SMCSuperIO		-	IO 传感器驱动
USBInjectAll		-	USB 注入驱动
VirtualSMC		-	SMC 核心驱动
VoodooI2C		-	I2C 触摸设备核心驱动(Windows 设备管理器中存在 I2C HID 设备时需要)
VoodooI2CHID		-	I2C 触摸设备扩展驱动(Windows 设备管理器中存在 I2C HID 设备时需要)
VoodooPS2Controller	-	PS2 设备驱动(键盘触摸板)
WhateverGreen		-	显卡必备驱动
XHCI-unsupported	-	不受原生支持的 USB 注入驱动(查看 Hackintool 中 USB 项，XHC 控制器 ID 在如下列表中时使用此驱动)
	- 8086:8D31
	- 8086:A2AF
	- 8086:A36D
	- 8086:9DED
```

## Contribute

希望更多的人和我一起维护完善，同型号的朋友可以进我的群，共同交流学习。

![](https://raw.githubusercontent.com/athlonreg/Thunderobot-911-Air-i7-9750h/master/misc/qqgroup.png)
