# Preference Graph Agent OS (formerly Tag4U)

## Introduction

Preference Graph Agent OS is a personal memory system combined with specialized AI agents.

Its core idea is simple:

Instead of treating preferences, social knowledge, and experience as implicit information living only in the user’s head, the system externalizes them into a persistent, editable preference graph that agents can reason over.

This is not merely a recommendation app.

It is not just “AI trip planning”.

It is a preference-centric memory layer powering domain-specific agents.

---

## Core Concept

The system consists of two layers:

### 1. Preference Memory Layer

A long-term memory graph storing:

- Personal preferences  
- Friend / relationship models  
- Shared small-group preferences  
- Personal judgments about places, activities, objects  
- Implicit constraints and social dynamics

This acts as reusable memory rather than repeated prompting.

---

### 2. Specialized Agent Layer

Agents use the memory graph to perform reasoning and planning.

Examples:

- Group outing planning agent  
- Restaurant / activity decision agent  
- Social coordination agent  
- Gift or invite suggestion agent  
- Personal reflection and relationship analysis agent

Agents are interfaces over the memory graph.

---

## Why It Is Different

Traditional recommendation systems optimize hard constraints:

- price  
- distance  
- ratings

This system also models soft constraints:

- atmosphere fit  
- social compatibility  
- ambiguity / “not awkward” preferences  
- nuanced human judgments

This is enabled by semantic preference representation and fuzzy matching.

---

# Core Functional Modules

## 1. People Preference Profiles

Each person can have:

Structured attributes:

- Food preferences  
- Personality notes  
- Transportation constraints  
- Social traits

Semantic preference notes:

Freeform descriptions such as:

- dislikes crowded places  
- spontaneous but dislikes sudden plan changes  
- prefers quieter first-meeting environments

These can be private or shared.

---

## 2. Place Memory Graph

Each place has two layers:

### Public Semantic Layer
Machine-generated from:

- Map/POI data
- Reviews
- LLM-derived embeddings

Examples:

- scenic
- noisy but lively
- good for first dates
- high-effort but memorable

---

### Personal Experience Layer
User or group-generated high-weight memory:

Examples:

- worth revisiting
- overrated despite reviews
- good only with close friends

This layer has highest ranking weight.

---

## 3. Group Preference Reasoning

Input:

- participants
- objective constraints
- preference graph

Output:

- ranked options
- conflict-aware recommendations
- itineraries

Hybrid reasoning:

Hard constraints:
Classical optimization/filtering

Soft constraints:
Semantic matching / LLM reasoning

---

## 4. Preference Memory Feedback Loop

System learns from usage.

After activities, lightweight feedback updates memory:

Examples:

Was this:
- too crowded
- worth waiting for
- good for conversation

Memory grows through interaction.

---

## 5. Private Preference Cards (Optional)

Encrypted preference cards can be shared without exposing raw internal notes.

Useful for collaborative planning while preserving privacy.

---

# Initial Wedge Use Case

First focus:

Group outing decision agent.

Prompt example:

"We are four people, one vegetarian, one dislikes noisy places, two have a car, 3 hours tonight — suggest where to go."

This is the wedge use case.

Broader Agent OS grows from there.

---

# Long-Term Vision

Build a Personal Preference Graph that powers many agents.

Not another assistant.

A persistent preference graph specialized agents can reason over.


# 4/27/2026
    现有的人物页面改成“Tag”页面，Tag页面中可以选择tag的object的分类，可以自行添加种类，基本预设种类是friends和餐厅。点击friends或餐厅的block，跳转到具体页面然后按字母表顺序显示具体的个体，用A，B，C等分隔不同的个体（像微信联系人列表的效果），餐厅也一样（沿用现在的block类型的按钮ui）。

    计划页面，更改成，点击功能选项（比如派对推荐）功能之后，弹出参与人员的list，然后勾选，删除现有的那个直接描述的输入框，选择完参与人物后增加下一个页面是选择本地tag过的目标地点，这个页面包括搜索栏快速搜索某个地点、地点的文字形式list、skip按钮（如果没什么想法的话），然后具体活动内容在这个规划页面的ai对话框输入就行了。对话框上部显示两个小的条，内容是人数和选择的地点数“xx人”“xx地点”，点击这个条可以修改参与人和地点，这种用户手动增加的地点要比网络信息提供的地点权重高一点点（你先自行定夺权重逻辑，并将设定的变量位置告诉我）


# 4/28/2026
    现在这个计划规划的功能保留,但是和我的list匹配的逻辑不一致。在app下方增加一个list的主要功能，放在中间位置，block使用蓝色底色区分，具体功能是，只使用个人保存的人物card做参与人，只使用保存的地点做目标，页面中有地点、活动内容两个大框，框里是保存过的相关tag，然后点击页面下方实时显示出符合的地点结果的5个地点，按照最佳匹配值排序。应该不需要使用ai和网络，直接设计一个本地数据库匹配查询逻辑即可

# 5/2/2026 (1)
    现在存在一个问题，大量的用户自定义tag会造成matching页面有大量的tag，这些tag很多意思是相近或者重复的，我需要增加一个背景功能叫“fusion”利用ai语义分析，将用户自定义的意思相近的tag做模糊合并，但是请注意“不要显式的修改用户存放的信息”，只是在matching页面只显示fusion之后的结果，以减少tag的数量和重复度。

    instruction as followed:
    Implement a background feature called “Fusion” for the matching page.

    The goal of Fusion is to reduce the visual clutter caused by many user-defined tags with similar or overlapping meanings.

    Fusion should use AI semantic understanding to group similar tags and show a cleaner, merged version on the matching page.

    Important logic:

    1. Fusion is only a display-layer abstraction.
    2. The system must never directly modify, overwrite, delete, rename, or merge the original user-created tags stored in the database.
    3. The original tags remain the only source of truth.
    4. The matching page may display fused/normalized tag results, but these fused tags are virtual UI representations only.
    5. Whenever the user interacts with, selects, filters by, or reasons over a fused tag, the system should implicitly trace it back to the original underlying tags.
    6. This backtracking should happen internally and should not be exposed as a separate user-facing operation.
    7. Fusion should reduce repeated or semantically similar tags while preserving the user’s original wording and data integrity.
    8. Avoid aggressive merging. Tags should only be fused when their meanings are clearly similar or overlapping.
    9. The final behavior should make the matching page cleaner without changing what the user actually saved.
   
# 5/2/2026 (2)
    matching page, 首先，把人和活动类型放在最上面，其次，现在人的tag没有影响到结果的生成。需要更改业务逻辑。

# 5/3/2025
    其实我可以先做一个最小方案，先不做app搜集用户本地数据蒸馏。单只做，自己给自己tag，可以有public tag和private tag，然后可以share，tag名片严格加密，被分享的用户只能看到被设置为public的tag。然后可以在本地给其他好友增加自己自定义的本地tag。最后user flow是，今天去哪玩（设置主题），然后添加参与者的名片，算法结合地点数据推荐结果。

    新增用户个人主页面，内容包括我的tag，头像，左边一个框是public tag， 右边一个private tag。
    人物从名片页面中移除，变成独立页面，好友列表的形式，每一个好友名片点开，有好友的public tag集合，和用户给对方的自定义tag集合。
    
    彻底移除ai行程规划页面和相关功能，matching页面暂时保留。增加一个ai对话输入框（仅仅是一个条形输入框不要占用整个页面）点击后可以原地展开显示ai对话记录的形式。有一个参与人选择区域，在其中添加好友（包括自己）等参与人。剩下功能暂时不变，然后有一个recommend按钮，将“参与人名片信息”“对话框输入的今天要做什么的内容”和“保存的地点名片”三个数据发送给ai进行匹配，并返回排序结果，显示在现在matching的结果那个位置（现有功能不破坏，如果用户调用主动matching之后再用ai返回的结果覆盖）
