# HiBeamer

> **极简 · 克制 · 高级**
>
> 一套专为高中数学、物理授课设计的 LaTeX Beamer 模板。
> 采用 LaTeX3（expl3）语法书写，追求极简的视觉美学与排版舒适度。

---

## 目录

- [设计哲学](#设计哲学)
- [快速开始](#快速开始)
- [文档类选项](#文档类选项)
- [核心功能](#核心功能)
  - [语义区块环境](#语义区块环境)
  - [例题与练习列表](#例题与练习列表)
  - [多层列表定制](#多层列表定制)
  - [诗词过渡页](#诗词过渡页)
  - [深色模式 / 浅色模式](#深色模式--浅色模式)
  - [讲义模式](#讲义模式)
  - [页面翻页按钮](#页面翻页按钮)
  - [行内高亮与快捷命令](#行内高亮与快捷命令)
  - [TikZ 绘图样式](#tikz-绘图样式)
  - [表格·图表·公式编号](#表格图表公式编号)
  - [排版增强](#排版增强)
- [扩展宏包](#扩展宏包)
  - [ChoiceQuestion：选择题与填空题](#choicequestion选择题与填空题)
  - [PhyUnit：物理单位](#phyunit物理单位)
- [进阶微调](#进阶微调)
- [文件结构](#文件结构)
- [致谢](#致谢)
- [开源协议](#开源协议)

---

## 设计哲学

在冗杂花哨的课件泛滥的今天，本模板坚信：**克制即是高级**。

我们摒弃了默认 Beamer 模板廉价的圆角、粗笨的线条和刺眼的纯色块，转而从顶尖学术期刊与现代 UI 设计中汲取灵感：

- **色彩克制**：极简冷灰底 + 学术藏青骨架 + 哑光金点缀，营造沉稳的学术氛围。
- **空间榨取**：单行顶栏左右布局、极限压缩无效留白，把最宝贵的垂直空间还给推导与公式。
- **强对比度**：深色标题栏 + 纯白/深字，左侧竖线 + 微底色，确保投影环境下后排学生依然清晰可见。
- **文理交融**：独创的"诗词点睛"过渡页，在严密的数理逻辑间隙，注入一抹人文浪漫。
- **讲练合一**：一键切换讲义模式，完美压平动画并排版为 A4 打印格式（4 on 1），兼顾投影与印发。
- **双色主题**：内置浅色/深色（黑板风格）两套完整配色，一键切换，全部 10+ 语义区块环境自动适配。

---

## 快速开始

### 环境要求

| 依赖项 | 说明 |
|--------|------|
| 编译引擎 | XeLaTeX 或 LuaLaTeX（必须，用于字体、中文和 unicode-math 支持） |
| TeX 发行版 | TeX Live 2022 及以上（推荐完整安装） |
| 思源宋体 | Source Han Serif CN（需系统安装） |
| TeX Gyre 字体 | Pagella / Heros / Pagella Math（TeX Live 自带） |

### 编译

将仓库中所有文件（`HiBeamer.cls`、`quotes.csv` 及所需宏包）放在工作目录下，运行：

```bash
xelatex main.tex    # 首次编译
xelatex main.tex    # 二次编译（生成目录和页码）
```

> 需要二次编译的原因：LaTeX 需要在 `.aux` 中写入目录信息、交叉引用和页码总数。

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

所有选项均通过 `\documentclass[<options>]{HiBeamer}` 传入。

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `randomquote` | bool | `false` | 章节过渡页是否随机抽取诗词。`true` 随机，`false` 按 CSV 顺序循环。 |
| `quoteseed` | int | `-1` | 伪随机种子。非负整数时固定随机序列（适合定稿课件）；`-1` 为真随机。 |
| `handout` | bool | `false` | 讲义模式。压平所有叠加动画，缩放排版为 A4（4 on 1）打印。 |
| `shownav` | bool | `false` | 是否在页面底部显示 TikZ 翻页按钮。`true` 显示，`false` 隐藏。 |
| `darkmode` | bool | `false` | 深色模式（黑板风格）。`true` 深色，`false` 浅色。 |

**示例：**

```latex
% 浅色 + 顺序诗词 + 隐藏翻页按钮（默认配置）
\documentclass{HiBeamer}

% 深色模式 + 随机诗词 + 固定种子
\documentclass[darkmode=true, randomquote=true, quoteseed=2026]{HiBeamer}

% 讲义模式 + 关闭诗词随机
\documentclass[handout, randomquote=false]{HiBeamer}

% 全部开启
\documentclass[darkmode=true, randomquote=true, shownav=true]{HiBeamer}
```

---

## 核心功能

### 语义区块环境

模板提供 **10 个语义区块环境**，覆盖课堂教学的全部场景。所有环境均支持可选参数 `[标题]`，由 `tcolorbox` 渲染，左侧配有对应的竖线色标与微背景底色。

| 环境 | 全称 | 竖线颜色 | 背景色 | 适用场景 |
|------|------|----------|--------|----------|
| `thm` | Theorem | 藏青 | 冷灰底 | 定理、定律 |
| `defn` | Definition | 藏青 | 冷灰底 | 定义、概念 |
| `imp` | Important | 哑光金 | 暖黄底 | 核心考点、重点强调 |
| `warn` | Warning | 赤陶红 | 浅红底 | 易错点、警示 |
| `eg` | Example | 哑光金 | 浅金底 | 例题讲解 |
| `ex` | Exercise | 赤陶红 | 浅红底 | 练习、随堂测试 |
| `tip` | Tip | 青色 | 浅青底 | 解题技巧、补充说明 |
| `memo` | Memo | 藏青/灰 | 冷灰底 | 备课笔记、教案备注 |
| `supp` | Supplement | 蓝色 | 浅蓝底 | 拓展知识、超纲内容 |
| `solve` | Solution | 藏青 | 冷灰底 | 解答过程（自动前缀"**解：**"） |

> `solve` 环境不接受 `[标题]` 可选参数——它始终自动添加"解："前缀。

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

---

### 例题与练习列表

`ExampleList` 和 `ExerciseList` 是定制化的 enumerate 环境，使用全局计数器实现**跨页自动连续编号**，并以 TikZ 装饰标签呈现"**例**-N"（金色）和"**练**-N"（红色）样式。

**基本用法：**

```latex
\begin{frame}{例题精讲}
  \begin{ExampleList}
    \item 质量为 $m$ 的物体在水平面上减速，求加速度。
    \item 一根轻弹簧上端固定，下端悬挂质量为 $m$ 的物体...
  \end{ExampleList}
\end{frame}
```

**环境可选参数：**

| 参数 | 行为 |
|------|------|
| `[0]` | 计数器重置为 1 |
| `[<+->]` | 启用逐项叠加动画（每个 `\item` 逐步显示） |
| 无参数 | 延续上一个 `ExampleList` / `ExerciseList` 的编号 |

**跨页连续编号示例：**

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

`ExerciseList` 用法完全一致，标签为红色"**练**-N"。

> **技术细节**：通过 `\resetcounteronoverlays` 确保 Beamer 的 overlay 动画机制下计数器不会重复递增。

---

### 多层列表定制

模板重新定义了 `itemize` 和 `enumerate` 的 3 层样式，颜色与符号逐层递进。

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
  \item 确定研究对象
  \item 受力分析，画出受力图
  \item 建立坐标系
  \item 列出分量方程
\end{itemize}
```

另外，`enumerate` 可以接受自定义标签（如中文圈数字、罗马数字）：

```latex
\begin{enumerate}
  \item[Ⅰ.] 第一部分：基础概念
  \begin{enumerate}
    \item[①] 力的定义
    \item[②] 力的三要素
  \end{enumerate}
\end{enumerate}
```

> 模板已通过 `\xeCJKsetcharclass` 修复中文圈数字和罗马数字在 Beamer 下的显示问题。

---

### 诗词过渡页

每个 `\section{}` 之前自动插入一张精心设计的过渡页：左侧淡色章节编号水印（`\insertsectionnumber`），右侧居中显示章节标题（带金色下划线），右下角随机展示一首古诗词及其出处。

**数据源：** `quotes.csv`（Tab 分隔），包含 318 首经典诗词。

| 列 | 含义 | 示例 |
|----|------|------|
| 第 1 列 | 作者 | 李商隐 |
| 第 2 列 | 作品 | 夜雨寄北 |
| 第 3 列 | 诗句 | 何当共剪西窗烛，却话巴山夜雨时。 |

**控制方式：**

```latex
% 顺序播放（按 CSV 行序循环，默认）
\documentclass{HiBeamer}

% 真随机抽取
\documentclass[randomquote=true]{HiBeamer}

% 固定种子（每次编译诗词顺序一致，适合定稿）
\documentclass[randomquote=true, quoteseed=2026]{HiBeamer}
```

**诗词显示逻辑：**

| 模式 | 行为 |
|------|------|
| `randomquote=false`（默认） | 按 CSV 顺序循环，依次递增 |
| `randomquote=true, quoteseed=-1` | 真随机，每次编译不同 |
| `randomquote=true, quoteseed=N` | 伪随机，种子固定则顺序固定 |

诗词库为空或 CSV 缺失时，过渡页优雅降级——不显示诗词区域，但章节标题和编号水印正常渲染。

**自定义诗词库：** 编辑 `quotes.csv`，遵循 Tab 分隔、三列格式即可。格式要求：
- 分隔符为 Tab（`\t`）
- 每行三列：作者、作品、诗句
- 无表头行

---

### 深色模式 / 浅色模式

模板内置完整的浅色与深色（黑板风格）两套配色方案，一键切换。所有语义区块、列表、TikZ 图形、导航按钮等组件均自动适配。

**使用方式：**

```latex
% 浅色模式（默认）
\documentclass{HiBeamer}

% 深色模式（黑板风格）
\documentclass[darkmode=true]{HiBeamer}
```

**自动适配范围：**

- 全部 14 种语义颜色（文字、边框、背景、强调色）自动切换
- Beamer 色彩系统（`normal text`、`structure`、列表颜色）自动重置
- 页面底色切换（浅色：白 / 深色：`#1A1D22`）
- 10 个 tcolorbox 区块正文颜色显式适配
- TikZ 网格线、过渡页水印透明度、导航按钮底色自动调整
- `ChoiceQuestion` 宏包自动检测深色模式并同步 `AnswerGreen`、`BGAnswer`、选择题标签颜色

**配色对比：**

| 色彩名 | 浅色值 | 深色值 | 用途 |
|--------|--------|--------|------|
| PrimaryNavy | `#1A2A40` | `#78AAD4` | 标题、规则线 |
| AccentGold | `#C5A065` | `#DFC585` | 强调、装饰 |
| AlertTerra | `#C75C5C` | `#ED8A84` | 警告、练习 |
| InfoTeal | `#2A9D8F` | `#66C6BA` | 技巧、提示 |
| SuppBlue | `#3A6EA5` | `#88B4D6` | 拓展阅读 |
| TextDark | `#050505` | `#D2D4D6` | 正文 |
| BGCoolGray | `#F5F7FA` | `#2E3338` | 区块底色 |
| BGDark | — | `#1A1D22` | 页面底色（仅深色） |

---

### 讲义模式

课堂投影使用 16:9 全屏，印发给学生时一键切换为 A4 讲义。

```latex
\documentclass[handout]{HiBeamer}
```

**讲义模式的行为：**

- 自动将 `handout` 选项传递给 Beamer，压平所有 `<+->` 逐项叠加动画
- 默认使用 `pgfpages` 的 **4 on 1** 布局（横向 A4，4 张幻灯片）
- 如需切换为 **2 on 1**（左侧幻灯片 + 右侧留白做笔记），编辑 `HiBeamer.cls` 第 47-66 行注释的布局切换代码

---

### 页面翻页按钮

底部左右两侧可显示触控友好的翻页按钮（TikZ 绘制于 `background canvas` 底层）。点击左箭头（◀）切换上一页、右箭头（▶）切换下一页。

```latex
% 启用翻页按钮
\documentclass[shownav=true]{HiBeamer}
```

**按钮属性：**

- 位置：页面左下角（◀）和右下角（▶），距页边 0.4cm
- 样式：半透明圆角矩形底 + 实心三角箭头
- 颜色：深色模式下 `NavBtnBg`（`#3E4349`），浅色模式下 `LightGray!25`
- 覆盖：所有页面（含 `[plain]` 过渡页、标题页）
- 首帧自动隐藏左箭头

---

### 行内高亮与快捷命令

| 命令 | 效果 | 颜色 | 用途 |
|------|------|------|------|
| `\hl{重点}` | 加粗高亮 | 哑光金 | 强调重点、核心概念 |
| `\hlwarn{易错点}` | 加粗警告 | 赤陶红 | 警示易错点、陷阱 |

```latex
运用牛顿第二定律时，\hl{正交分解}是最核心的方法。
计算冲量时，\hlwarn{绝不能}直接使用 $I = Ft$。
```

---

### TikZ 绘图样式

模板预置 4 套 TikZ 样式，配色与主题一致，可直接绘制坐标轴与函数曲线：

| 样式 | 效果 | 典型用途 |
|------|------|----------|
| `highend-axis` | 藏青箭头坐标轴，线宽 1.1pt | 坐标轴 |
| `highend-curve` | 哑光金曲线，线宽 1.3pt | 函数曲线 |
| `highend-grid` | 虚线网格，步长 1cm | 坐标网格 |
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

---

### 表格·图表·公式编号

**三线表：** 模板已加载 `booktabs` 并自定义了表格线宽（`\heavyrulewidth=1.2pt`，`\lightrulewidth=0.8pt`）和颜色（藏青）。使用 `\toprule`、`\midrule`、`\bottomrule` 即可获得专业级三线表。

```latex
\begin{tabular}{ccc}
  \toprule
  列一 & 列二 & 列三 \\
  \midrule
  数据1 & 数据2 & 数据3 \\
  \bottomrule
\end{tabular}
```

**图表标题：**

- 图表自动编号，标签为藏青加粗
- 图标题位于下方，表标题位于上方
- 子图/子表标签使用哑光金加粗
- 标签中文化：图 → "图"，表 → "表"

**公式编号：** 所有带编号的公式（`equation` 环境）编号自动套用藏青色圆括号样式。

```latex
\begin{equation}
  \vec{F} = m \vec{a}                    % 编号为藏青色 (1)
\end{equation}
```

---

### 排版增强

**文本对齐：** Beamer 默认在列表环境中使用 `\raggedright`，导致长文本右侧参差不齐。模板通过 `\RenewDocumentCommand{\raggedright}{}{\justifying}` 恢复两端对齐，确保文字排版整齐。

**行间距：** 使用 `zhlineskip` 宏包，设置全局行距倍数为 1.4，确保中文排版舒适。

**description 环境：** 已配置 `description width=4em`，确保术语解释有适当的标签宽度：

```latex
\begin{description}
  \item[质点] 在某些问题中，可忽略物体的形状和大小，视为有质量的点。
  \item[刚体] 在任何外力作用下，形状和大小保持不变的物体（理想模型）。
\end{description}
```

**中文圈数字与罗马数字：** 通过 `\xeCJKsetcharclass` 修复了 Unicode 圈数字（①-⑩）和罗马数字（Ⅰ-Ⅹ）在 Beamer 中的显示问题。

**Overlay 透明效果：** 配置了 `\setbeamercovered{transparent=15}`，使被遮罩的内容半透明而非完全消失，辅助学生理解推导步骤间的关联。

**双栏布局：** 支持标准 Beamer `columns` 环境：

```latex
\begin{columns}[T]
  \begin{column}{0.48\linewidth}
    \begin{defn}[动能]
      E_k = \frac{1}{2}mv^2
    \end{defn}
  \end{column}
  \begin{column}{0.48\linewidth}
    \begin{defn}[重力势能]
      E_p = mgh
    \end{defn}
  \end{column}
\end{columns}
```

---

## 扩展宏包

### ChoiceQuestion：选择题与填空题

提供选择、填空、解答、作图共 4 种题型命令，自动检测文档类（Beamer / Book）并提供对应功能。

**加载方式：**

```latex
\usepackage[answer_shown=true]{ChoiceQuestion}
```

**加载选项：**

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `answer_shown` | bool | `false` | 是否显示答案（`true` 显示高亮答案） |
| `answer_color` | tl | `AnswerGreen` | 答案高亮颜色 |

---

#### Beamer 模式命令

##### 选择题答案 — `\xzanswer{选项}`

分两页展示：第 1 页显示空括号 `(  )`，第 2 页显示正确答案。

```latex
关于牛顿第一定律，下列说法正确的是？ \xzanswer{B}
```

##### 填空题答案 — `\tkanswer{答案}`

`answer_shown=true` 时显示高亮文字（带底纹下划线）；`false` 时显示等宽下划线占位。

```latex
牛顿第二定律的数学表达式为 \tkanswer{$\vec{F}=m\vec{a}$}。
```

> **双模式注意**：`true` 时适合老师授课投影（直接显示答案），`false` 时适合打印学生讲义（隐藏答案仅供填空）。

##### 选择题选项网格 — `\fourchoices[opts]{A}{B}{C}{D}`

使用 `exam-zh-choices` 提供自动列数优化的选项布局。

**选项键 `answer`：** 指定正确答案（单个或多个字母），第 2 页自动变色高亮。

```latex
% 单选
\fourchoices[answer=B]
  {物体不受力时，总保持静止状态}
  {力是改变物体运动状态的原因}
  {物体运动不需要力来维持的说法是错误的}
  {力是维持物体运动的原因}

% 多选
\fourchoices[answer=CD]
  {曲线运动一定是变速运动}
  {曲线运动的加速度一定变化}
  {曲线运动的速度方向一定变化}
  {曲线运动所受合外力一定不为零}
```

**选项键 `ispicture`：** 用于图片选项，`true` 时标签放置于底部。

```latex
\fourchoices[answer=A, ispicture=true]
  {\includegraphics[width=2cm]{fig-a.pdf}}
  {\includegraphics[width=2cm]{fig-b.pdf}}
  {\includegraphics[width=2cm]{fig-c.pdf}}
  {\includegraphics[width=2cm]{fig-d.pdf}}
```

##### 解答题 — `\jdanswer{内容}`

第 1 页留空（`\vfill`），第 2 页显示绿色左边框 `tcolorbox` 解答区域。

```latex
\begin{ExerciseList}
  \item 斜面上的物体受力分析综合题。
  \jdanswer{
    取物体为研究对象，受力分析如下...
  }
\end{ExerciseList}
```

##### 作图/连线题 — `\drawpicanswer{原图}{答案图}`

第 1 页显示原图（供学生作答时参考），第 2 页显示答案图。

```latex
\drawpicanswer{%
  \begin{tikzpicture}...原图...\end{tikzpicture}%
}{%
  \begin{tikzpicture}...答案图...\end{tikzpicture}%
}
```

---

#### Book 模式额外命令

在 Book 文档类下，除上述命令外，额外提供 2-6 选项的选择题命令：

| 命令 | 参数签名 | 选项数 |
|------|----------|--------|
| `\twochoices[opts]{A}{B}` | `O{}mm` | 2 |
| `\threechoices[opts]{A}{B}{C}` | `O{}mmm` | 3 |
| `\fourchoices[opts]{A}{B}{C}{D}` | `O{}mmmm` | 4 |
| `\fivechoices[opts]{A}{B}{C}{D}{E}` | `O{}mmmmm` | 5 |
| `\sixchoices[opts]{A}{B}{C}{D}{E}{F}` | `O{}mmmmmm` | 6 |

Book 模式下，答案直接以内联颜色高亮显示，无 Beamer 的分页动画。

---

#### 深色模式自动适配

ChoiceQuestion 宏包会自动检测 `HiBeamer.cls` 中声明的 `\g__highend_dark_mode_bool` 变量：

- 深色模式：`AnswerGreen` 切换为浅绿色（`#4ECCA3`），`BGAnswer` 切换为深色（`#2E3338`），选择题标签默认颜色改为 `TextDark`
- 浅色模式：`AnswerGreen` 为深绿色（`#1A7A5C`），`BGAnswer` 为浅绿（`#E8F5EF`）

---

### PhyUnit：物理单位

提供约 **160 个**物理单位快捷宏命令，每个命令以 `\U` 为前缀，自动处理正体罗马体排版和前导空格。

**设计原则：** 命令名等于单位缩写加常见复合形式。例如 `\Ums` = m/s、`\Umsq` = m/s²、`\UNmqCq` = N·m²/C²。

**基本用法：**

```latex
\Ukg       % → kg（质量）
\Um        % → m（长度）
\Ums       % → m/s（速度）
\Umsq      % → m/s²（加速度）
\UN        % → N（力）
\UJ        % → J（能量）
\UW        % → W（功率）
\UHz       % → Hz（频率）
\UPa       % → Pa（压强）
\UdC       % → ℃（温度）
\UO        % → Ω（电阻）
\UV        % → V（电压）
\UF        % → F（电容）
```

**可选参数 `[a]`：** 用于紧接数字之后，省略前导空格：

```latex
质量为 $0.5\Ukg$ 的物体...    % "0.5 kg" 之间有前导空格
质量为 $0.5\Ukg[a]$ 的物体...  % "0.5kg" 无空格（紧贴）
```

**复合单位示例：**

```latex
$k = 9.0 \times 10^9 \UNmqCq$     % 静电力常量 k = 9.0×10⁹ N·m²/C²
$G = 6.67 \times 10^{-11} \UNmqkgq$ % 万有引力常量 G
$e/m_e = 1.76 \times 10^{11} \UCkg$ % 荷质比
$\rho = 1.7 \times 10^{-8} \UOm$    % 电阻率
```

**完整单位列表请参阅 `PhyUnit.sty` 源代码。**

---

## 进阶微调

所有间距参数均可在 `HiBeamer.cls` 中直接修改。文件采用模块化注释分隔（模块一到七），便于定位。

| 调整项 | 搜索关键词 | 推荐范围 |
|--------|-----------|----------|
| 全局行距 | `bodytextleadingratio` | 1.2 ~ 1.45 |
| 左右页边距 | `text margin left=1cm` | 0.8cm ~ 1.5cm |
| 标题栏间距 | `frametitle` 处的 `\vskip` | -5pt ~ 5pt |
| 讲义布局 | `handout` 模块中的 `pgfpagesuselayout` | 2 on 1 或 4 on 1 |
| description 宽度 | `description width=4em` | 2.5em ~ 6em |

**更换字体：** 编辑模块二中的 `\setCJKmainfont`、`\setsansfont` 等命令。

**自定义颜色：** 编辑模块二中 `\definecolor` 系列命令，浅色/深色模式各自独立定义。

**关闭 Section 过渡页：** 在 `HiBeamer.cls` 中注释掉 `\AtBeginSection[]` 代码块（约第 320-354 行）。

---

## 文件结构

```
HiBeamer/
├── HiBeamer.cls             # 主文档类（Beamer 模板核心，7 个模块）
├── ChoiceQuestion.sty       # 选择题 / 填空题 / 解答题宏包
├── PhyUnit.sty              # 物理单位宏包（~160 个快捷命令）
├── quotes.csv               # 诗词数据库（318 首，Tab 分隔，三列无表头）
├── main.tex                 # 功能测试与演示文档
├── main.pdf                 # 编译输出（示例 PDF）
├── main.aux / .log / .nav   # LaTeX 辅助文件（编译产物，.gitignore 中排除）
├── package/
│   ├── exam-zh-choices.sty  # 选择题选项排版引擎（ChoiceQuestion 依赖）
│   └── exam-zh-doc.pdf      # exam-zh-choices 文档 PDF
├── .gitignore               # 排除编译产物与编辑器临时文件
└── README.md                # 本文档
```

**HiBeamer.cls 模块结构：**

| 模块 | 行号范围 | 功能 |
|------|----------|------|
| 模块一 | 1-67 | 文档类声明、LaTeX3 选项处理、讲义模式布局 |
| 模块二 | 91-174 | 浅色/深色双配色定义、西文/CJK/数学字体设置 |
| 模块三 | 176-354 | 诗词引擎、翻页按钮、帧标题、页脚、目录、Section 过渡页 |
| 模块四 | 356-370 | itemize/enumerate 三层列表样式定制 |
| 模块五 | 372-429 | tcolorbox 语义区块环境（thm/defn/imp/warn/eg/ex/tip/supp/memo/solve） |
| 模块六 | 431-446 | TikZ 绘图样式、表格规则线、行内高亮命令 |
| 模块七 | 448-595 | 图表标题、公式编号、ExampleList/ExerciseList、排版增强 |

---

## 致谢

- 高考试卷 LaTeX 模板  https://gitee.com/xkwxdyy/exam-zh

## 开源协议

「随君所想，成君所愿」

---

**愿这套模板，能让你的数理课堂多一分严谨，少一分喧嚣。**
