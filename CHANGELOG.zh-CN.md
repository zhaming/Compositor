# 更新说明：简体中文界面

> 基线：上游 Compositor 1.5.2（`robbietilton/Compositor`）
> 本仓库：`zhaming/Compositor`
> 日期：2026-10-18

## 概述

为 Compositor 增加**简体中文界面**。界面会随系统语言自动切换：系统是中文就显示中文，是其他语言就回落到英文。原有的英文界面行为完全不变，随包同时提供 `en` 与 `zh-Hans` 两套字符串。

## 新增

- `Compositor/zh-Hans.lproj/Localizable.strings`：**962 条**简体中文翻译，与英文表的 key 集合严格一致
- `Compositor/en.lproj/Localizable.strings`：英文源表（962 条），作为翻译基准
- `Compositor/Localization.swift`：`String.localized` 与 `String?.localized` 扩展，让变量形式的界面文本也能查表
- `README.zh-CN.md`：本文件所在仓库的中文 README

覆盖范围：

| 位置 | 内容 |
|---|---|
| 菜单栏 | File / Edit / Image / Layer / Select / Filter / View / Window / Help 全部条目，含 **Filter、Image、Layer 的二级菜单**（高斯模糊、动感模糊、色相/饱和度、色阶、曲线…） |
| 图层面板 | 右键菜单全部条目、图层行副标题（文件夹 / 文本 · 双击编辑 / 剪贴至…）、悬停提示、辅助功能标签 |
| 面板下拉 | 单位、通道、形状、抖动、裁切比例、Camera Raw 各页签与采样方式 |
| Camera Raw | 各分区折叠标题、滑块标签、提示、复位按钮 |
| 画布工具 | 工具栏提示、选区扩展/收缩、裁切、渐变、文字等控件文案 |
| 对话框 | 新建画布、画布大小、图像大小、裁剪、网格、导出为、未保存更改确认、错误提示、软件更新 |
| 快捷键设置 | 分组名 + 98 条快捷键标题 |
| 命令面板（⌘F） | 全部工具与图层命令 |
| 其他 | 撤销/重做步骤名（如"撤销 画笔描边"）、标签页名（"未命名"）、窗口标题 |

## 修复

翻译不是"放一份 strings 文件"就结束了。三轮修改中修掉的问题：

**第一轮 —— 只放 `Localizable.strings`**
- 主菜单能翻译，但二级菜单、下拉选项、图层面板右键菜单全是英文。

**第二轮 —— 变量与插值**

SwiftUI 的 `Text("Save")` 会自动查表，因为它编译成 `LocalizedStringKey`；但只要文本来自变量或字符串插值，编译器就换成 `Text(String)` 重载，**原样显示、从不查表**。修复：

1. 新增 `String.localized` 扩展，给 78 处变量渲染补上查表
2. 19 处 AppKit 菜单（`NSMenuItem` / `NSMenu`）手动本地化
3. 插值串改为格式串（`"Undo \(name)"` → `"Undo %@"`），让语序可以随语言调整
4. 修复一处因翻译而失效的逻辑：`validateMenuItem` 原本拿菜单项**标题**当标识，标题翻译后比较必然失败 → 改用 `NSUserInterfaceItemIdentifier`
5. 命令面板的菜单跳过名单同时收录原文与译文，否则 `Window` / `Help` 翻译后匹配不上、会被错误列出

**第三轮 —— 更隐蔽的三类**

1. **插值后紧接 `.localized`**：`"Hide \(name) in the preview".localized` 查的是插值结果，永远命中不了 → 改成格式串
2. **AppKit 属性赋值**：`alert.messageText`、`alert.informativeText`、`sheet.title`、`panel.title`、`toolTip`、`stringValue`、`addButton(withTitle:)` 完全不经过 SwiftUI，字面量直接显示 → 全部加 `.localized`
3. **前缀拼接**：`"Add " + kind.rawValue`（撤销步骤名）、`"Export " + format.rawValue` 拼出来的串在表里不存在 → 改成格式串
4. **`TextField` 占位符**：搜索框、不透明度、色值输入框等

顺带修掉两个真实缺陷：

- 图层行副标题 `"Clipped to \(name)"` 在两个独立方法里各拼了一次，两处都漏
- 空白文档名 `"Untitled"` 被当作数据使用，5 处代码拿它做相等比较；直接翻译会导致标签页重名。改为 `ProjectWorkspace.untitledBase` 单一来源，**显示与比较共用同一个字符串**

## 翻译规模

| 迭代 | 条目数 |
|---|---|
| 初版 | 434 |
| 第二轮 | 899 |
| 第三轮 | **962** |

自动化审计（扫描 `Text`、`Button`、`Picker`、`.help`、`.accessibilityLabel`、`NSMenuItem(title:)`、`NSLocalizedString`、`"…".localized`、`toolTip = "…"`、`addButton(withTitle:)`、`TextField("…")` 等写法）：源码中 926 条用户可见字符串，**917 条命中**；剩余 9 条是 `NSLocalizedString` 的 `comment:` 说明参数与 `\r`、`\u{…}` 转义字符，不面向用户 —— 实际覆盖率 **100%**。

## 术语

按 Photoshop 简体中文版用词统一：图层、选区、蒙版、剪贴蒙版、混合模式、正片叠底、滤色、色相/饱和度、色阶、曲线、仿制图章、内容识别填充、Camera Raw、污点修复画笔、渐变映射等。技术记号（`PNG`、`EXR`、`HDR`、`RGB`、`DPI`、`px`）保持原样。

## 验证方式

```sh
# 1. 编译
xcodebuild -project Compositor.xcodeproj -scheme Compositor \
  -configuration Debug -derivedDataPath ./DerivedData build

# 2. 中文系统直接启动
open ./DerivedData/Build/Products/Debug/Compositor.app

# 3. 英文系统下临时预览中文
defaults write com.wonderassembly.compositor AppleLanguages '("zh-Hans")'
open ./DerivedData/Build/Products/Debug/Compositor.app
```

重点检查：Filter / Image / Layer 二级菜单、图层面板右键与悬停提示、Camera Raw 各分区标题、快捷键设置面板、⌘F 命令面板、保存对话框、标签页名。

## 已知限制

- 只有 `en` 与 `zh-Hans` 两套字符串；其他语言回落到英文
- 文字工具的用户输入文本、文件名、图层名等**数据**不翻译（这是正确行为）
- 上游的翻译政策仍是不接受翻译 PR；本次改动仅存在于本 fork

## 许可

与上游一致，MIT。
