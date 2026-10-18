# Compositor

[English](README.md) · **简体中文**

Adobe Photoshop 太贵，GIMP 之类的工具又不够顺手，用起来很难保持心流状态。所以我做了 Compositor。

目标是做一个功能完整、完全免费开源的图像编辑器。我以前用 Photoshop 做合成和后期处理，所以 Compositor 就是围绕这套流程搭起来的——把「做出像素级精确的最终画面」所需的工具都放进去。

因为是开源的，你可以下载 Xcode 工程，按自己的流程增删改任何功能。

> **本仓库（`zhaming/Compositor`）的差异**：在上游基础上新增了**简体中文界面**。
> 译者笔记与实现方式见 [本次更新说明](CHANGELOG.zh-CN.md)，界面文本位于
> `Compositor/zh-Hans.lproj/Localizable.strings`。

## 安装

### 直接下载

从 [robbietilton.com/compositor](https://robbietilton.com/compositor) 获取 Compositor，或直接从
[GitHub Releases](https://github.com/robbietilton/Compositor/releases/latest) 下载最新版本。

### Homebrew

```sh
brew install --cask robbietilton-compositor
```

## 功能

### 图层

- 图层与图层组，支持不透明度，以及 Photoshop 全套混合模式（顺序与 PS 一致）——图层组的不透明度会作用于组内所有内容
- 图层蒙版：可在画布任意位置（包括超出图层自身像素的范围）绘制、填充、反相、模糊与羽化；可链接或取消链接，以便单独变换蒙版
- 剪贴蒙版与图层组蒙版
- 调整图层：色相/饱和度、色阶、曲线、曝光度、渐变映射、颗粒、黑白、色彩平衡、反相、高斯模糊、动感模糊、杂色
- 图层效果：描边、投影、颜色叠加、内阴影、外发光、内发光，GPU 渲染，随时可再编辑
- 向下合并、合并图层、合并组（⌘E）
- 复制、就地重命名、拖放调整顺序与嵌套；按住 Option 拖动即可复制；图层面板提供右键菜单
- 在没有选区时用 ⌘C/⌘V 可整层复制粘贴图层与图层组，同一项目内、项目之间，或直接把图层拖到另一个项目

### 变换

- 非破坏性的移动、缩放、旋转与翻转——图像无论缩小到什么程度都保留原始分辨率
- 自由扭曲（⌘ 拖动控制点），按住 Shift 可锁定单一轴向
- 同时变换多个图层，或整个图层组
- 吸附到画布与图层边缘、中心点，并显示参考线
- 位置、尺寸、缩放、角度均可输入精确数值，也可用方向键步进
- 水平/垂直翻转图层、水平/垂直翻转画布

### 选区

- 矩形与椭圆选框、自由套索与多边形套索，以及魔棒工具集——魔棒按颜色选择，对象工具描出你点击的内容（Tab 切换）
- 选择主体，以及对任意选区做扩展、收缩与羽化
- 加选、减选、移动选区轮廓，或移动与复制选区内的像素
- 把图层像素或蒙版载入为选区
- 内容识别填充，也可以用它把图像向边缘之外扩展

### 绘制与修饰

- 画笔：可设大小、硬度、不透明度与平滑，支持绘画与擦除模式（B 与 E），按住 Shift 画直线
- 污点修复画笔（内容识别）
- 仿制图章：可选对齐或不对齐，可采样单层或所有图层
- 模糊工具，可作用于像素或蒙版
- 渐变工具与形状工具（矩形、圆角矩形、椭圆、直线），保持可编辑而不被栅格化
- 文字工具（T）：在可拖动、可缩放的段落框中就地多行编辑；字体、字号、颜色、对齐与间距在工具栏中设置；可变换文字，也可把文字用作剪贴蒙版
- 吸管与完整的取色器

### 调整与滤镜

- Camera Raw 滤镜：光照、颜色、曲线、颜色混合器、颜色分级、细节、光学、几何，面板位于画布旁；每个分区都可以从标题处复位为默认值
- 色阶（含自动）、曲线、色相/饱和度、曝光度、渐变映射、颗粒、黑白、色彩平衡、反相
- 高斯模糊与动感模糊，效果可扩散到图层边缘之外
- 添加杂色、晕影、泛光/发光、抖动、扫描线、色调对比、镜头校正、移除背景
- 实时预览；存在选区时，预览与效果都限制在选区内
- 上次滤镜（⌃⌘F）用同一组参数再次执行

### 画布与文件

- 多项目标签页
- 搜索命令（⌘F）：像 Raycast、Obsidian 那样按名称查找所有菜单命令与工具，回车执行
- 切换全屏（F）：画布单独铺满全屏黑底，所有面板收起；再按 F 或 Esc 恢复
- 标尺（⌘R）、从标尺拖出的参考线、可调节间距与细分数的布局网格，以及参考线/网格/图层/文档边界的吸附
- 裁剪可吸附，支持 3:4、9:16 等比例，按住 Option 对称裁剪；有选区时从选区开始裁剪
- 画布大小、图像大小、裁剪（Trim）
- 缩放超过 300% 时画布角落出现导航器缩略图：整个文档缩略显示，视口以方框标出；点击或拖动即可移过去（View › Navigator）
- 缩小时使用锐利的高质量降采样，放大时显示像素网格
- 导入 JPEG、PNG、HEIC、TIFF、WebP、SVG、相机 RAW（先走一次显影步骤），以及 Photoshop PSD 和 PSB（8 位 RGB，不支持 CMYK）。Photoshop 的图层组、蒙版、混合模式、填充矩形/椭圆、简单横排文字保持可编辑；其余矢量与竖排文字转为像素。应用之前会先显示转换报告。
- 大文档：内存预算随 Mac 配置伸缩；大到无法打开的 Photoshop 文件会把图层裁剪到画布范围内
- 导出 PNG（⇧⌘E）、导出 JPEG（⇧⌥⌘S），以及「导出为」（⇧⌥⌘W）——PNG、JPEG 或按印刷尺寸输出一页 PDF，可缩放，带实时预览、JPEG 质量与文件大小；拷贝合并
- 保存项目时仍可继续工作
- 全程沿用 Photoshop 风格的快捷键，可在「编辑 › 键盘快捷键」中重新映射
- 拖动数值标签即可拖动调节数值，与 Photoshop 一致
- 自动更新，已签名并公证

### 与 AI 智能体协作

- AI 智能体与脚本可以直接创建、编辑项目：`.comp` 就是一个装着 PNG 图层和一份清单的文件夹，打开的项目会随写入实时更新。详见 [Writing Compositor projects](docs/writing-comp-files.md)

## 系统要求

- macOS 26.0 或更高版本，Apple 芯片的 Mac
- Xcode 26 或更高版本（从源码构建时需要）

## 翻译

上游 Compositor 目前只有英文界面，也不接受翻译 PR：它由一个人维护，此后每条新文案都需要翻译，而维护者读不懂的语言也无法审校。

本仓库是个人 fork，额外提供了**简体中文**界面，中英文可随系统语言自动切换。相关改动见 [CHANGELOG.zh-CN.md](CHANGELOG.zh-CN.md)，实现细节见 [LOCALIZATION_REPORT.md](LOCALIZATION_REPORT.md)。

## 构建

打开 `Compositor.xcodeproj`，运行 **Compositor** scheme。

命令行构建：

```sh
xcodebuild -project Compositor.xcodeproj -scheme Compositor \
  -configuration Debug -derivedDataPath ./DerivedData build
open ./DerivedData/Build/Products/Debug/Compositor.app
```

首次构建会拉取 Sparkle 2.10.0。App 启动后跟随系统语言。

## 发布

`scripts/release.sh` 会构建 Release 版本、用 Developer ID 签名、公证并 staple，最后打包成 `dist/Compositor-<version>.dmg`。

它需要以下东西，全部放在仓库之外：

- 登录钥匙串中的 **Developer ID Application** 证书
- 用 `xcrun notarytool store-credentials "compositor-notary" …` 保存的公证凭证
- [`create-dmg`](https://github.com/create-dmg/create-dmg)（`brew install create-dmg`）

## 许可

MIT — 见 [LICENSE](LICENSE)。
