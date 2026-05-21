# HighendMathBeamer 🎓✨

> **极简 · 克制 · 高级感**
> 一套专为高中数学、物理授课设计的 LaTeX Beamer 模版，采用 LaTeX3 语法底层重构，追求极致的视觉美学与排版舒适度。

## 🌟 设计哲学

在冗杂花哨的课件泛滥的今天，本模版坚信：**克制即是高级**。

我们摒弃了默认 Beamer 模版廉价的圆角、粗笨的线条和刺眼的纯色块，转而从顶尖学术期刊与现代 UI 设计中汲取灵感，确立了以下设计原则：

- **色彩克制**：极简冷灰底 + 学术藏青骨架 + 哑光金点缀，营造沉稳的学术氛围。
- **空间榨取**：单行顶栏左右布局、极限压缩无效留白，把最宝贵的垂直空间还给推导与公式。
- **强对比度**：深色标题栏 + 纯白/深字，左侧竖线 + 微底色，确保投影环境下后排学生依然清晰可见。
- **文理交融**：独创的“诗词点睛”过渡页，在严密的数理逻辑间隙，注入一抹人文浪漫。
- **讲练合一**：一键切换讲义模式，完美压平动画并排版为 A4 打印格式，兼顾投影与印发。

## ✨ 核心特性

- 🎨 **现代色彩系统**：9 套高辨识度语义配色（藏青定理、金色强调、赤陶警告、青色提示等）。
- 📐 **专业字体搭配**：中文思源宋体/黑体 + 西文 Palatino/Heros，完美适配数理幻灯片投影。
- 📦 **9 大语义区块**：`thm`, `defn`, `imp`, `warn`, `eg`, `ex`, `tip`, `memo`, `supp`，告别混乱排版。
- 🔢 **深层列表定制**：修复了 Beamer 多年顽疾，3 层有序/无序列表完美自增，支持复杂嵌套。
- 🧮 **公式与图表**：定制三线表、图表自动编号、公式编号主题色化、TikZ 极简绘图样式库。
- 🎋 **诗词过渡页**：从 CSV 文件随机抽取古诗词作为章节过渡，显示作者与作品，支持随机/顺序模式及随机种子。
- 🖨️ **一键讲义模式**：支持 `handout` 选项，压平所有 `[<+->]` 逐项动画，并自动缩放排版为 A4 讲义（2 on 1 或 4 on 1）。
- ⚙️ **LaTeX3 底层**：样式文件采用 LaTeX3 编写，逻辑严密，接口优雅，易于扩展。

## 🚀 快速开始

### 环境要求

- **编译引擎**：XeLaTeX 或 LuaLaTeX（必须）
- **宏包发行版**：TeX Live 2022 及以上（推荐完整安装）
- **字体依赖**：
  - 思源宋体
  - 思源黑体
  - TeX Gyre Pagella / Heros / Pagella Math（TeX Live 自带）

### 编译项目

1. 将 `HighendMathBeamer.cls` 和 `quotes.csv` 放在工作目录下。
2. 使用以下命令编译主文件（需编译**两次**以生成正确目录和页码）：

```bash
xelatex main.tex
xelatex main.tex
```

### 最小示例

```latex
\documentclass{HighendMathBeamer}

\title{高中物理：动量守恒}
\author{授课教师}
\date{\today}

\begin{document}

\begin{frame}[plain]
  \titlepage
\end{frame}

\begin{frame}{Outline}
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

## 📖 详细使用指南

### 1. 诗词过渡页配置

模版会在每个 `\section{}` 前自动插入精美的过渡页，右下角展示诗词及出处。

**控制选项**（在 `\documentclass` 中设置）：

```latex
% 默认：真随机（每次编译诗句不同）
\documentclass{HighendMathBeamer}

% 伪随机：指定种子（每次编译诗句顺序固定，适合定型课件）
\documentclass[randomquote=true, quoteseed=42]{HighendMathBeamer}

% 顺序播放：按 CSV 从上到下循环
\documentclass[randomquote=false]{HighendMathBeamer}
```

**数据源格式** (`quotes.csv`)：
必须使用 **Tab 分隔**，包含三列：`作者` `作品` `诗句`。

```csv
李商隐	夜雨寄北	何当共剪西窗烛，却话巴山夜雨时。
苏轼	定风波	试问岭南应不好？却道：此心安处是吾乡。
```

渲染效果：
> 何当共剪西窗烛，却话巴山夜雨时。
> —— 李商隐 ⋅ 夜雨寄北

### 2. 语义区块环境

只需使用对应的环境名，模版会自动处理左侧竖线、背景底色和强对比标题栏。

| 环境   | 缩写含义   | 标题栏颜色 | 适用场景           |
| :----- | :--------- | :--------- | :----------------- |
| `thm`  | Theorem    | 藏青       | 定理、定律         |
| `defn` | Definition | 藏青       | 定义、概念         |
| `imp`  | Important  | 哑光金     | 核心考点、重点强调 |
| `warn` | Warning    | 赤陶红     | 易错点、警示       |
| `eg`   | Example    | 哑光金     | 例题               |
| `ex`   | Exercise   | 赤陶红     | 练习、随堂测试     |
| `tip`  | Tip        | 青色       | 解题技巧、补充说明 |
| `memo` | Memo       | 灰色       | 备课笔记、教案备注 |
| `supp` | Supplement | 蓝色       | 拓展知识、超纲内容 |

**示例**：

```latex
\begin{eg}[斜面问题]
  质量为 $m$ 的物体在倾角为 $\theta$ 的斜面上...
\end{eg}
```

### 3. 列表与逐项动画

支持 3 层嵌套，颜色与符号逐层递进（金块 → 藏青三角 → 灰点），编号自动修正。

使用 `[<+->]` 可以让列表逐项显示：

```latex
\begin{itemize}[<+->]
  \item 第一点
  \item 第二点
\end{itemize}
```

### 4. 讲义模式（A4 打印）

课堂投影使用 16:9 全屏模式，而印发给学生时需要 A4 讲义。模版通过 `handout` 选项一键切换。

```latex
% 启用讲义模式：自动压平所有 [<+->] 动画，并缩放为 A4 排版
\documentclass[handout]{HighendMathBeamer}
```

**布局切换**：默认启用 4 on 1 布局。如需改为左侧幻灯片、右侧留白做笔记的 2 on 1 布局，请打开 `HighendMathBeamer.cls`，在模块一末尾的 `pgfpages` 设置区取消注释对应布局即可。

### 5. TikZ 绘图样式库

内置 4 套符合主题配色的坐标轴与曲线样式，直接调用即可画出顶级刊物质感的图像：

```latex
\begin{tikzpicture}
  \draw[highend-grid] (-3,-2) grid (3,2);               % 冷灰虚线网格
  \draw[highend-axis] (-3.2,0) -- (3.2,0);              % 藏青极细坐标轴
  \draw[highend-curve, domain=-2:2] plot (\x, {\x*\x}); % 哑光金饱满曲线
  \draw[highend-aux] (1,0) -- (1,1);                    % 浅灰辅助线
\end{tikzpicture}
```

### 6. 快捷行内命令

- `\hl{重点词}`：哑光金加粗高亮。
- `\hlwarn{易错词}`：赤陶红加粗高亮。

### 7. 图表与公式编号

- 图表自动编号，标签为藏青加粗，子图标签为哑光金。
- 行间公式编号自动应用藏青色圆括号样式。

## ⚙️ 进阶微调

所有间距参数均可在 `HighendMathBeamer.cls` 中直接修改：

- **全局行距**：搜索 `\linespread{1.3}`，调节数值（推荐 1.2~1.35）。
- **页面边距**：搜索 `\setbeamersize{text margin left=1cm}`，调节左右边距。
- **标题栏与正文间距**：搜索 `\setbeamertemplate{frametitle}`，调节 `\vskip` 数值。

## 📜 开源协议

本项目基于 **LPPL (LaTeX Project Public License) v1.3c** 协议开源。

鼓励自由使用、修改和分发，但请保留原始作者的版权声明。若您在公开场合使用或基于此模版衍生，请注明本仓库地址。

---

**愿这套模版，能让你的数理课堂多一分严谨，少一分喧嚣。**