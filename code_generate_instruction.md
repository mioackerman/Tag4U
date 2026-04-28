SYSTEM DESIGN INSTRUCTION

Build a Flutter-first application implementing a Personal Memory + Group Planning Agent architecture.

Do NOT treat this as a generic recommendation app.

Treat it as a personal memory system + specialized agent framework.

The core value proposition:
- Users accumulate private place memories over time.
- When planning a group activity, the system combines personal memories + participant preference profiles + real-time external data, then uses LLM reasoning to produce ranked recommendations.

Prioritize simplicity, modularity, and LLM-first reasoning over complex graph computation.

---

ARCHITECTURE OVERVIEW

Use clean architecture:

Presentation
Domain
Data
Infrastructure

Prefer repository pattern + provider/notifier architecture.

Use Drift for local persistent storage (simple relational, not graph-heavy).

Use Supabase for sync/auth/optional cloud storage.

Use Google Places API as the canonical source for place data and geocoding.

Use an LLM API (e.g. Claude or OpenAI) as the reasoning engine.

---

CORE DATA MODEL

Design flat, text-first entities. Avoid complex graph structures in the database layer.
Let LLM handle semantic reasoning instead of storing weighted edges.

Entities:

User
PersonProfile
PlaceMemory
ActivitySession
RecommendationPlan

---

PERSON PROFILE

Each person (self or contact) has a free-text preference profile.

Fields:

id
name
avatar (optional)
preference_note        // free-form text: "doesn't eat spicy food, likes quiet environments, budget-conscious"
created_at
updated_at

No rigid tag schema.
Preference notes are written naturally and read by LLM.
Profile is updated progressively as user learns more about each person.

---

PLACE MEMORY

Each saved place must have a verified address obtained via Google Places API at save time.

Fields:

id
name
user_note              // free-form text: "parking is easy, good for large groups, service is slow but portions are big"
formatted_address      // from Google Places API
lat                    // from Google Places API geocoding
lng                    // from Google Places API geocoding
place_id               // Google place_id, store for future enrichment
category               // e.g. "restaurant", "cafe", "park"
created_at

Mandatory: lat, lng, place_id must be populated at save time via Google Places API call.
Do not allow saving a place without geocoding.

Address resolution flow:
1. User inputs place name or rough address.
2. System calls Google Places API (text search or autocomplete).
3. User confirms the matched result.
4. System stores formatted_address, lat, lng, place_id automatically.

---

TWO-LAYER PLACE DATA

At recommendation time, merge two data sources per candidate place:

1. Personal memory layer
User's own PlaceMemory record (private notes, past experiences).

2. Public real-time layer
Google Places API data: ratings, opening hours, photos, recent reviews.

Both layers are passed as text context to the LLM reasoning call.
Do not attempt to merge them programmatically. Let LLM synthesize.

---

RECOMMENDATION PIPELINE

Pipeline stages:

Stage 1: Intent extraction (LLM call 1)

Input:
- User's natural language activity description
  Example: "Tomorrow 5 of us are going to Markham for dinner, mainly Chinese food"
- Participant PersonProfiles (preference_note for each person)

LLM extracts structured intent:
- Location area
- Activity type and cuisine/category
- Group size
- Key constraints derived from participant preferences
  (e.g. "one person is vegetarian", "avoid noisy places", "need parking")

Output: IntentSummary (structured text, not rigid schema)

---

Stage 2: Candidate retrieval (parallel, no LLM)

Track A — Personal memories:
Query PlaceMemory table.
Filter by geographic proximity to target location using lat/lng radius calculation.
Filter by category if applicable.

Track B — Real-time external data:
Call Google Places API with location + category query.
Retrieve name, address, rating, opening hours, price level, review snippets.

Merge Track A and Track B into a unified candidate list.
Deduplicate by place_id or proximity matching.

Cap total candidates at ~50 before passing to LLM.

---

Stage 3: LLM semantic ranking (LLM call 2)

Input:
- IntentSummary from Stage 1
- Candidate place list with all available text data (personal notes + public data)

LLM performs:
- Semantic preference matching against group needs
- Group compatibility assessment across all participants
- Practical constraint checking (open tomorrow, suitable group size, etc.)

Output:
- Ranked recommendation list (top 5-10)
- Per-recommendation reasoning text
- Optional: itinerary or visit order suggestion

---

Stage 4: Optional itinerary synthesis (LLM call 3, on demand)

User may request a full itinerary from the ranked list.
LLM generates a time-sequenced plan with logistics notes.

---

HARD FILTERS (pre-LLM, rule-based)

Apply before Stage 3 to reduce candidate count:

- Distance radius (using lat/lng math)
- Opening hours (using Google Places data)
- Category match (coarse filter only)

Do not over-engineer hard filters.
Keep them simple. Let LLM handle nuance.

---

AGENT LAYER

Design a minimal agent interface abstraction.

Base Agent:

analyze(context) → IntentSummary
retrieve(intentSummary) → CandidateList
rank(candidateList, intentSummary) → RankedRecommendations

Initial agent:

GroupPlanningAgent

Implements the full pipeline above.

Future agents (extensible without redesign):

SoloActivityAgent
GiftResearchAgent
TravelItineraryAgent

All agents share:
- Access to PlaceMemory repository
- Access to PersonProfile repository
- LLM reasoning interface
- Google Places API interface

---

FEEDBACK LOOP

After an activity, prompt user with lightweight feedback.

Feedback updates:
- PlaceMemory user_note (append new observations)
- PersonProfile preference_note (update if new preferences discovered)

Feedback UI must be minimal: 1-2 taps + optional text note.
Do not design complex rating systems.
Free-text notes are preferred; LLM will read them next time.

---

PRIVACY

All PlaceMemory and PersonProfile data is private by default.
Stored locally via Drift.
Synced to Supabase only if user opts in.

Support optional shareable preference cards:
- User exports a PersonProfile as a shareable card.
- Other users can import it as a contact's profile.
- Shared cards contain only preference_note, not place memories.

---

UX REQUIREMENTS

Minimal onboarding.
No mandatory tag creation.
Memory builds naturally through usage.

Key flows:

1. Save a place:
   - Input name or rough address
   - Confirm Google Places match
   - Add optional free-text note
   - Done in under 30 seconds

2. Plan a group activity:
   - Describe activity in natural language
   - Select participants from contacts
   - System runs pipeline automatically
   - User receives ranked list with reasons

3. Post-activity feedback:
   - Lightweight prompt after activity
   - Optional note append
   - No forced structured input

---

GOOGLE PLACES API INTEGRATION

Use Google Places API for:

- Place search and autocomplete (when user saves a new place)
- Geocoding (lat/lng resolution at save time)
- Place details retrieval (opening hours, ratings, reviews at recommendation time)
- Nearby search (Stage 2 Track B candidate retrieval)

Always store place_id at save time to enable cheap future lookups.
Do not re-geocode addresses that already have a place_id.

---

LLM INTEGRATION

Use a single LLM provider interface (abstracted, swappable).

LLM is called at:
- Stage 1: Intent extraction
- Stage 3: Semantic ranking
- Stage 4: Itinerary synthesis (optional)

Always pass data as structured plain text prompts.
Do not use embeddings or vector databases in v1.
Let the LLM context window handle semantic matching directly.

Target context size per Stage 3 call: under 8000 tokens.
Enforce candidate cap at Stage 2 to stay within limit.

---

FUTURE-PROOFING

Design system as a Personal Memory + Agent platform, not a single-purpose restaurant finder.

Keep agent interfaces generic.
Keep LLM prompt construction modular.
Keep PlaceMemory and PersonProfile schemas minimal and extensible.

Optimize for adding new agent types without touching core data layer.

---

CODING PRIORITIES

Generate production-oriented Flutter code.

Focus first on:

1. Data models (PersonProfile, PlaceMemory, ActivitySession, RecommendationPlan)
2. Drift schema (simple relational, text-first)
3. Repository layer (PlaceMemoryRepository, PersonProfileRepository)
4. Google Places API service (geocoding, place search, place details)
5. LLM service interface (prompt builder + API call abstraction)
6. GroupPlanningAgent (pipeline orchestration)
7. Recommendation pipeline stages (modular, independently testable)

Do not begin with UI-heavy prototypes.
Begin from system foundation.