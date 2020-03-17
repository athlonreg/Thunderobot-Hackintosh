>  根据 CPU 型号选择相应的热补丁

- ***SSDT-PNLF-SNB_IVY***：2, 3 代亮度补丁。
- ***SSDT-PNLF-Haswell_Broadwell***： 4, 5 代亮度补丁。
- ***SSDT-PNLF-SKL_KBL***：6, 7 代亮度补丁。
- ***SSDT-PNLF-CFL***：8 代+ 亮度补丁。

> 注意事项

- 当使用定制亮度补丁时，需注意补丁都是在`_SB`下注入的`PNLF`设备，当原始`ACPI`中存在`PNLF`字段时，需将其更名，否则会影响`Windows`引导。也可以用[`RehabMan`的补丁](https://github.com/RehabMan/OS-X-Clover-Laptop-Config/tree/master/hotpatch)。更名如下：

  ```swift
  // PNLF to XNLF
  Find:    504E 4C46
  Replace: 584E 4C46
  ```

