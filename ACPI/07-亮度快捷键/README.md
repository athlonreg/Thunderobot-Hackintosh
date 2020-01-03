>  在原始 DSDT 中搜索 `0x86)`，找到如下图所示位置，观察左下角出现的 DSDT 所处位置，将此方法(例子中为 _Q60 和Q11、Q12)按照模板重写。0x86) 和 0x87) 出现在两个 Method 的情况(如 SSDT-BKeyQ11Q12-Thunderobot-911-MT-9750h 按照 Q11Q12 的模板重写)，出现在一个 Method 的情况(如 SSDT-BKeyQ60-Thunderobot-911-Air2-9750h 和 SSDT-BKeyQ60-Thunderobot-911K-7700HQ 按照 Q60 的模板重写)。

![BKey-01](https://raw.githubusercontent.com/athlonreg/Thunderobot-Hackintosh/master/imgs/BKey-01.png)

修改方法示例

![BKey-02](https://raw.githubusercontent.com/athlonreg/Thunderobot-Hackintosh/master/imgs/BKey-02.png)