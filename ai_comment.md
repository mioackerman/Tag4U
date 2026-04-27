核心概念（已经不只是“tag app”）

你原始想法其实可以重述成：

一个基于可编辑偏好图（editable preference graph）的 soft-constraint planning engine。

不是普通推荐App。

不是普通AI agent壳。

这是本质。

为什么有价值
1. 它解决的是现有系统不擅长的问题

传统推荐：

hard filters
keyword search
ratings sort

你想处理：

模糊偏好
多人约束
场景化规划

这是不同问题。

2. semantic tag 是 reusable preference memory

不是每次prompt重写：

我怕吵
朋友晕车
我讨厌排队

这些变成长期偏好图。

这是比单次LLM prompt多出来的东西。

3. 传统规则系统做不好 fuzzy matching

这是你最强论点。

hard constraints：

预算、距离。

soft constraints：

氛围、默契、不尴尬感。

这里 LLM/embedding 有价值。

技术上合理路线（不是纯大模型乱生成）

最合理架构：

Hybrid:

hard constraints
→ classical optimization / filtering
soft constraints
→ semantic embeddings / LLM matching
planner
→ itinerary generation

这个靠谱。

最大创新点

不是 “tag everything”。

而是：

把隐性偏好显式表示出来，并用于约束推理。

这才新。

最大风险
（1）容易只是feature，不像company

被 OpenAI 或 Google agent吃掉。

必须强调：

persistent preference graph

否则没护城河。

（2）tag输入负担高

用户懒。

必须靠：

自动推断
用户修正

不能靠手填tag。

（3）自由语义会漂移

“舒服”“有意思”容易误解。

要 learned ontology，不是纯自由文本。

（4）低频问题

“去哪玩”频率可能不够撑产品。

要缩小切口但留扩张性。

我对产品方向建议（如果真做）

不要叫：

Tag Everything

太像空洞口号。

应该叫：

Preference Engine for Group Planning

或者更简单：

AI Planner with Editable Preference Graph

我对idea评价（现在）
作为普通课程项目：

很强。

作为创业想法：

新颖性：8.5/10
技术合理性：8/10
独立公司护城河：6/10
如果定位成 preference engine infra：7.5-8/10

最后一个我们讨论出来的重要升级

最初是：

tag → ai 推荐

后来升级成：

semantic preference representation

soft constraint reasoning
hybrid optimization

这已经不是一个量级了。