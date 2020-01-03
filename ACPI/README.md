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
