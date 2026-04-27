SYSTEM DESIGN INSTRUCTION

Build a Flutter-first application implementing a Preference Graph Agent OS architecture.

Do NOT treat this as a generic recommendation app.

Treat it as a personal memory system + specialized agent framework.

Prioritize extensibility, modularity, and graph-based data modeling.

---

ARCHITECTURE OVERVIEW

Use clean architecture:

Presentation
Domain
Data
Infrastructure

Prefer repository pattern + provider/notifier architecture.

Use Drift for local persistent graph storage.

Use Supabase for sync/auth/optional cloud storage.

---

CORE DATA MODEL

Design graph-oriented entities.

Entities:

User
PersonNode
PlaceNode
PreferenceTag
SemanticDescriptor
RelationshipEdge
GroupMemory
AgentTask
RecommendationPlan

Relationships should support:

Person ↔ PreferenceTag
Place ↔ SemanticDescriptor
Person ↔ Place memories
Person ↔ Person relational edges

Model should support weighted edges.

Example:

friend dislikes_noise weight=0.9

place good_first_date weight=0.8

---

TWO-LAYER PLACE MODEL

Implement:

1 Public semantic place layer
Machine-generated descriptors.

2 Personal memory layer
User-generated judgments.

Store separately and merge during ranking.

---

HYBRID REASONING ENGINE

Separate:

Hard constraint engine

For:

distance
budget
availability

Use rule filtering.

---

Soft constraint engine

Use embeddings + LLM reasoning interface.

Allow semantic preference matching.

Do not hardcode tags as rigid booleans.

Tags may be free-form descriptors.

---

AGENT LAYER

Design agent interface abstraction.

Base Agent:

analyze(context)

plan(context)

rank(options)

Agents plug into same preference graph.

Initial agent:

GroupPlanningAgent

Future agents extensible.

---

RECOMMENDATION PIPELINE

Pipeline:

retrieve candidate places

apply hard filters

semantic preference scoring

group compatibility scoring

generate ranked recommendations

optional itinerary synthesis

Modularize each stage.

---

FEEDBACK LOOP

Support post-activity memory updates.

Feedback modifies:

preference weights

place memory

group memories

Design reinforcement loop.

---

PRIVACY

All personal preference memory private by default.

Support encrypted optional shared preference cards.

Design privacy boundaries into data model.

---

UX REQUIREMENTS

Minimal onboarding.

No heavy manual tag creation upfront.

Memory should emerge through usage.

Use lightweight interactions:

quick preference chips
lightweight post-event feedback
progressive memory building

Avoid overwhelming ontology editors.

---

FUTURE-PROOFING

Design system as Preference Graph + Agents platform, not single-purpose trip planner.

Keep agent interfaces generic.

Optimize for adding future agents without redesign.

---

CODING PRIORITIES

Generate production-oriented Flutter code.

Focus first on:

data models
graph repositories
Drift schema
agent abstractions
recommendation pipeline skeleton

Do not begin with UI-heavy prototypes.

Begin from system foundation.