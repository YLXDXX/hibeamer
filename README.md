# HiBeamer

> **极简 · 克制 · 高级感**
>
> 一套专为高中数学、物理授课设计的 LaTeX Beamer 模板。采用 LaTeX3（expl3）语法底层重构，追求极致的视觉美学与排版舒适度。

---

## 目录

- [设计哲学](#设计哲学)
- [快速开始](#快速开始)
  - [环境要求](#环境要求)
  - [编译](#编译)
  - [最小示例](#最小示例)
- [文档类选项](#文档类选项)
- [核心功能](#核心功能)
  - [语义区块环境](#语义区块环境)
  - [例题与练习列表](#例题与练习列表)
  - [多层列表定制](#多层列表定制)
  - [诗词过渡页](#诗词过渡页)
  - [讲义模式](#讲义模式)
  - [行内高亮与快捷命令](#行内高亮与快捷命令)
  - [TikZ 绘图样式](#tikz-绘图样式)
  - [表格、图表与公式编号](#表格图表与公式编号)
- [扩展宏包](#扩展宏包)
  - [ChoiceQuestion：选择题与填空题](#choicequestion选择题与填空题)
  - [PhyUnit：物理单位](#phyunit物理单位)
- [进阶微调](#进阶微调)
- [文件结构](#文件结构)
- [开源协议](#开源协议)

---

## 设计哲学

在冗杂花哨的课件泛滥的今天，本模板坚信：**克制即是高级**。

我们摒弃了默认 Beamer 模板廉价的圆角、粗笨的线条和刺眼的纯色块，转而从顶尖学术期刊与现代 UI 设计中汲取灵感，确立了以下设计原则：

- **色彩克制**：极简冷灰底 + 学术藏青骨架 + 哑光金点缀，营造沉稳的学术氛围。
- **空间榨取**：单行顶栏左右布局、极限压缩无效留白，把最宝贵的垂直空间还给推导与公式。
- **强对比度**：深色标题栏 + 纯白/深字，左侧竖线 + 微底色，确保投影环境下后排学生依然清晰可见。
- **文理交融**：独创的"诗词点睛"过渡页，在严密的数理逻辑间隙，注入一抹人文浪漫。
- **讲练合一**：一键切换讲义模式，完美压平动画并排版为 A4 打印格式，兼顾投影与印发。

---

## 快速开始

### 环境要求

| 依赖项 | 说明 |
|--------|------|
| **编译引擎** | XeLaTeX 或 LuaLaTeX（必须） |
| **TeX 发行版** | TeX Live 2022 及以上（推荐完整安装） |
| **思源宋体** | Source Han Serif CN（需系统安装） |
| **TeX Gyre 字体** | Pagella / Heros / Pagella Math（TeX Live 自带） |

### 编译

将 `HiBeamer.cls`、`quotes.csv` 以及所需宏包（`ChoiceQuestion.sty`、`PhyUnit.sty`）放在工作目录下，运行：

```bash
xelatex main.tex
xelatex main.tex   # 需编译两次以生成正确目录和页码
```

### 最小示例

```latex
% !TEX program = xelatex
\documentclass{HiBeamer}

\title{高中物理：动量守恒}
\author{授课教师}
\date{\today}

\begin{document}

\begin{frame}[plain]
  \titlepage
\end{frame}

\begin{frame}{课程大纲}
  \tableofcontents
\end{frame}

\section{动量定理}

\begin{frame}{核心定义}
  \begin{defn}[动量]
    物体的质量与速度的乘积：$\vec{p} = m \vec{v}$
  \end{defn}

  \begin{warn}
    动量是矢量，必须规定正方向！
  \end{warn}
\end{frame}

\end{document}
```

---

## 文档类选项

所有选项均通过 `\documentclass[<options>]{HiBeamer}` 传入：

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `randomquote` | bool | `true` | 章节过渡页是否从 CSV 中随机抽取诗词。设为 `false` 时按 CSV 顺序循环播放。 |
| `quoteseed` | int | `-1` | 伪随机种子。设为非负整数时，每次编译的诗词顺序固定（适合定稿课件）；`-1` 为真随机。 |
| `handout` | bool | `false` | 讲义模式。压平所有 `<+->` 逐项动画，并自动缩放排版为 A4 打印（4 on 1）。 |

**示例：**

```latex
% 默认：真随机抽取诗词
\documentclass{HiBeamer}

% 固定随机种子，保证每次编译诗词顺序一致
\documentclass[randomquote=true, quoteseed=42]{HiBeamer}

% 顺序播放 + 讲义模式
\documentclass[randomquote=false, handout]{HiBeamer}
```

---

## 核心功能

### 语义区块环境

模板提供 10 个语义区块环境，覆盖课堂教学的全部场景。所有环境均支持可选参数 `[标题]`，左侧配有对应的竖线色标与背景底色。

| 环境 | 全称 | 边框颜色 | 背景颜色 | 适用场景 |
|------|------|----------|----------|----------|
| `thm` | Theorem | 藏青 | 冷灰底 | 定理、定律 |
| `defn` | Definition | 藏青 | 冷灰底 | 定义、概念 |
| `imp` | Important | 哑光金 | 暖黄底 | 核心考点、重点强调 |
| `warn` | Warning | 赤陶红 | 浅红底 | 易错点、警示 |
| `eg` | Example | 哑光金 | 浅金底 | 例题讲解 |
| `ex` | Exercise | 赤陶红 | 浅红底 | 练习、随堂测试 |
| `tip` | Tip | 青色 | 浅青底 | 解题技巧、补充说明 |
| `memo` | Memo | 灰色 | 冷灰底 | 备课笔记、教案备注 |
| `supp` | Supplement | 蓝色 | 浅蓝底 | 拓展知识、超纲内容 |
| `solve` | Solution | 藏青 | 冷灰底 | 解答过程（自动带"解："前缀） |

**基本用法：**

```latex
\begin{defn}[牛顿第二定律]
  物体的加速度跟合外力成正比，跟质量成反比：
  \[ \vec{F}_{\text{合}} = m \vec{a} \]
\end{defn}

\begin{eg}[斜面问题]
  质量为 $m$ 的物体在倾角为 $\theta$ 的斜面上匀速下滑，求动摩擦因数 $\mu$。
\end{eg}

\begin{solve}
  受力分析如下：重力 $mg$ 竖直向下，支持力 $N$ 垂直斜面向上...
\end{solve}
```

**效果：** 每个区块自动渲染左侧竖线 + 标题栏 + 微底色，视觉层次清晰，后排学生可轻松辨识。

### 例题与练习列表

`ExampleList` 和 `ExerciseList` 是定制化的 enumerate 环境，使用全局计数器实现跨页自动编号，并以 TikZ 装饰标签呈现"例-N"和"练-N"样式。

**基本用法：**

```latex
\begin{frame}{例题精讲}
  \begin{ExampleList}
    \item 质量为 $m$ 的物体在水平面上减速，求加速度。
    \item 一根轻弹簧上端固定，下端悬挂质量为 $m$ 的物体...
  \end{ExampleList}
\end{frame}
```

**环境选项：**

- `\begin{ExampleList}[0]` — 计数器重置为 1
- `\begin{ExampleList}[<+->]` — 启用逐项动画
- 无参数 — 延续上一个 `ExampleList` 的编号

**跨页连续编号：** 一个新 `ExampleList` 会从上一个结束的编号继续递增，无需手动维护。

```latex
% 第一页：例-1, 例-2
\begin{frame}{例题精讲（一）}
  \begin{ExampleList}
    \item 第一题...
    \item 第二题...
  \end{ExampleList}
\end{frame}

% 第二页：例-3, 例-4（自动连续）
\begin{frame}{例题精讲（二）}
  \begin{ExampleList}
    \item 第三题...
    \item 第四题...
  \end{ExampleList}
\end{frame}
```

> `ExerciseList` 用法完全一致，标签为红色"练-N"。

### 多层列表定制

模板重新定义了 `itemize` 和 `enumerate` 的 3 层样式，颜色与符号逐层递进：

**itemize（无序列表）：**

| 层级 | 符号 | 颜色 |
|------|------|------|
| 第 1 层 | ■（方块） | 哑光金 |
| 第 2 层 | ▸（三角） | 藏青 |
| 第 3 层 | ·（圆点） | 灰色 |

**enumerate（有序列表）：**

| 层级 | 格式 | 颜色 |
|------|------|------|
| 第 1 层 | `1.` 加粗数字 | 藏青 |
| 第 2 层 | `(a)` 加粗括号字母 | 哑光金 |
| 第 3 层 | `i)` 斜体数字 | 青色 |

**逐项动画：** 使用 Beamer 的 `[<+->]` 语法实现列表逐条显示：

```latex
\begin{itemize}[<+->]
  \item 第一点
  \item 第二点
  \item 第三点
\end{itemize}
```

### 诗词过渡页

每个 `\section{}` 前自动插入一张精心设计的过渡页：左侧淡色章节编号水印，中央显示章节标题（带金色下划线），右下角随机展示一首古诗词及其出处。

**数据源：** `quotes.csv`（Tab 分隔），包含 318 首经典诗词。

| 列名 | 内容示例 |
|------|----------|
| 作者 | 李商隐 |
| 作品 | 夜雨寄北 |
| 诗句 | 何当共剪西窗烛，却话巴山夜雨时。 |

**控制方式：**

```latex
% 真随机（默认）
\documentclass{HiBeamer}

% 固定种子，锁定诗词顺序
\documentclass[randomquote=true, quoteseed=2026]{HiBeamer}

% 按 CSV 顺序循环播放
\documentclass[randomquote=false]{HiBeamer}
```

**自定义诗词库：** 编辑 `quotes.csv`，遵循 Tab 分隔、三列格式即可。也支持完全不包含诗词的 Section 过渡（模板会优雅降级，不显示任何诗词区域）。

### 讲义模式

课堂投影使用 16:9 全屏，印发给学生时一键切换为 A4 讲义。

```latex
\documentclass[handout]{HiBeamer}
```

**讲义模式的行为：**
- 自动将 `handout` 选项传递给 Beamer，压平所有 `<+->` 逐项动画
- 默认使用 `pgfpages` 的 4 on 1 布局（横向 A4，4 张幻灯片）
- 如需 2 on 1（左侧幻灯片 + 右侧笔记区），编辑 `HiBeamer.cls` 第 47 行附近的布局注释

### 行内高亮与快捷命令

| 命令 | 效果 | 颜色 |
|------|------|------|
| `\hl{重点}` | 加粗高亮 | 哑光金 |
| `\hlwarn{易错点}` | 加粗警告 | 赤陶红 |

```latex
运用牛顿第二定律时，\hl{正交分解}是最核心的方法。
计算冲量时，\hlwarn{绝不能}直接使用 $I = Ft$。
```

### TikZ 绘图样式

模板预置 4 套 TikZ 样式，配色与主题一致，可直接绘制出坐标轴与函数曲线：

| 样式 | 效果 | 典型用途 |
|------|------|----------|
| `highend-axis` | 藏青箭头坐标轴，线宽 1.2pt | 坐标轴 |
| `highend-curve` | 哑光金曲线，线宽 2.0pt | 函数曲线 |
| `highend-grid` | 冷灰虚线网格，步长 1cm | 坐标网格 |
| `highend-aux` | 浅灰虚线辅助线，线宽 0.5pt | 辅助线、标注线 |

**示例：**

```latex
\begin{tikzpicture}
  \draw[highend-grid] (-0.5,-0.5) grid (4,3);
  \draw[highend-axis] (-0.5,0) -- (4.5,0) node[right] {$t$/s};
  \draw[highend-axis] (0,-0.5) -- (0,3.5) node[above] {$F$/N};
  \draw[highend-curve, domain=0:4, samples=50] plot (\x, {0.2*\x*\x});
  \draw[highend-aux] (4,0) -- (4,3.2);
  \fill[AccentGold, opacity=0.1] (0,0)
    -- plot[domain=0:4] (\x, {0.2*\x*\x}) -- (4,0) -- cycle;
\end{tikzpicture}
```

### 表格、图表与公式编号

**三线表：** 模板已加载 `booktabs` 并自定义了表格线宽（`\heavyrulewidth=1.2pt`，`\lightrulewidth=0.8pt`）和颜色（藏青）。使用 `\toprule`、`\midrule`、`\bottomrule` 即可得到专业级三线表。

**图表标题：**
- 图表自动编号，标签为藏青加粗
- 图标题位于下方，表标题位于上方
- 子图/子表标签使用哑光金加粗

**公式编号：** 所有带编号的公式（`equation` 环境）编号自动应用藏青色圆括号样式。

---

## 扩展宏包

### ChoiceQuestion：选择题与填空题

提供选择、填空、作图、解答四种题型命令，支持 Beamer 和 Book 两种文档类。

**加载选项：**

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `answer_shown` | bool | `true` | 是否显示答案 |
| `answer_color` | tl | `AnswerGreen` | 答案高亮颜色 |

```latex
\usepackage[answer_shown=true]{ChoiceQuestion}
```

#### 题型命令（Beamer 模式）

**选择题 — `\xzanswer{选项}`**

在 Beamer 中分两页展示：第 1 页显示空括号 `(  )`，第 2 页显示正确答案。

```latex
关于牛顿第一定律，下列说法正确的是？ \xzanswer{B}
```

**填空题 — `\tkanswer{答案}`**

`answer_shown=true` 时显示高亮文字；`false` 时显示等宽下划线占位。

```latex
牛顿第二定律的数学表达式为 \tkanswer{$\vec{F}=m\vec{a}$}。
```

**选择题选项网格 — `\fourchoices[opts]{A项}{B项}{C项}{D项}`**

使用 `exam-zh-choices` 提供四列选项布局，支持 `answer` 选项自动高亮正确答案。

```latex
\fourchoices[answer=C]
  {质量}
  {时间}
  {力}
  {长度}
```

`answer` 选项支持多选（如 `answer=ACD`），正确答案在第 2 页自动变色高亮。还支持 `ispicture` 模式用于图片选项。

**解答题 — `\jdanswer{内容}`**

第 1 页留空，第 2 页显示带颜色边框和背景的完整解答。

```latex
\begin{ExerciseList}
  \item 斜面上的物体受力分析综合题。
  \jdanswer{
    取物体为研究对象，受力分析...
  }
\end{ExerciseList}
```

**作图/连线题 — `\drawpicanswer{原图}{答案图}`**

第 1 页显示原图（供学生作答），第 2 页显示答案图。

#### Book 模式额外命令

在 Book 文档类下，除上述命令外，额外提供：

| 命令 | 选项数 |
|------|--------|
| `\twochoices[opts]{A}{B}` | 2 |
| `\threechoices[opts]{A}{B}{C}` | 3 |
| `\fivechoices[opts]{A}{B}{C}{D}{E}` | 5 |
| `\sixchoices[opts]{A}{B}{C}{D}{E}{F}` | 6 |

### PhyUnit：物理单位

提供约 160 个物理单位快捷宏命令，每个命令以 `\U` 为前缀，自动处理正体罗马体排版和前导空格。

**命名约定：** 命令名等于单位缩写加上常见复合形式。

**基本用法：**

```latex
\Ukg       % → \;kg（质量）
\Um        % → \;m（长度）
\Ums       % → \;m/s（速度）
\Umsq      % → \;m/s^2（加速度）
\UN        % → \;N（力，牛顿）
\UJ        % → \;J（能量，焦耳）
\UW        % → \;W（功率，瓦特）
\UHz       % → \;Hz（频率）
\UPa       % → \;Pa（压强，帕斯卡）
\UdC       % → \;℃（温度，摄氏度）
\UO        % → \;Ω（电阻，欧姆）
\UV        % → \;V（电压，伏特）
\UF        % → \;F（电容，法拉）
```

**可选参数 `[a]`：** 用于紧接数字之后，省略前导空格：

```latex
质量为 $0.5\Ukg$ 的物体...   % "0.5 kg" 之间有空格
质量为 $0.5$\Ukg[a] 的物体... % "0.5kg" 无空格（紧贴）
```

> 更多单位宏请参阅 `PhyUnit.sty` 源代码中的完整列表。

---

## 进阶微调

所有间距参数均可在 `HiBeamer.cls` 中直接修改：

| 调整项 | 搜索关键词 | 推荐范围 |
|--------|-----------|----------|
| 全局行距 | `bodytextleadingratio` | 1.2 ~ 1.45 |
| 左右页边距 | `text margin left=1cm` | 0.8cm ~ 1.5cm |
| 标题栏间距 | `frametitle` 内的 `\vskip` | -5pt ~ 5pt |
| 讲义布局 | `handout` 模块中的 `pgfpagesuselayout` | 2 on 1 或 4 on 1 |

**更换字体：** 编辑模块二中 `\setCJKmainfont` 等命令即可。

**自定义颜色：** 编辑模块二中 `\definecolor` 系列命令，修改 10 个语义色值。

**关闭 Section 过渡页：** 在 `HiBeamer.cls` 中注释掉 `\AtBeginSection[]` 代码块。

---

## 文件结构

```
HiBeamer/
├── HiBeamer.cls           # 主文档类（Beamer 模板核心）
├── ChoiceQuestion.sty    # 选择题/填空题/解答题宏包
├── PhyUnit.sty           # 物理单位宏包（~160 个快捷命令）
├── quotes.csv            # 诗词数据库（318 首，Tab 分隔）
├── main.tex              # 功能测试与演示文档
├── main.pdf              # 编译输出
├── package/
│   ├── exam-zh-choices.sty  # 选择题选项排版（依赖）
│   └── exam-zh-doc.pdf
└── README.md
```

---

## 开源协议

本项目基于 **LPPL (LaTeX Project Public License) v1.3c** 协议开源。

鼓励自由使用、修改和分发，但请保留原始作者的版权声明。若您在公开场合使用或基于此模板衍生，请注明本仓库地址。

---

**愿这套模板，能让你的数理课堂多一分严谨，少一分喧嚣。**
