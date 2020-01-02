- GPI0 补丁
  - 如果要启用 GPI0，其 `_STA` 必须 `Return (0x0F)`。

  - 样本仅供参考。使用时确认 GPI0 设备的 `_STA` 存在 `GPHD` 。

- TPD0 补丁
  - 从 Windows 设备管理器确定 I2C HID 的设备路径，示例中是 _SB.PCI0.I2C1.TPD0，路径不同的将模板中的路径修正为自己的设备路径。
  - 相应的将更名补丁也要修改。