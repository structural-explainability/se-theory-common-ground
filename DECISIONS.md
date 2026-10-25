# Design Decisions

This file does not introduce additional assumptions or requirements.

## Fragment-Relative Common Ground

Results hold for a stated referential fragment and a stated class of
frameworks.
They are not results for the full class of admissible frameworks, and they
neither assert nor weaken Neutral Substrate's `ReferentialCommonGround`.

A fragment must be satisfiable, nontrivial, and bounded.
Nontriviality matters: a valid commitment set is compatible with every
satisfiable framework, so a result about it would say nothing.

## Characterizing the Framework Class Independently

The framework class is characterized by what a framework permits on the
fragment's vocabulary.
The characterization mentions the vocabulary and the framework only.
It never mentions the fragment's commitments.

A condition that referred to agreement with the fragment's commitments would
make the compatibility result true by definition.

Admissibility alone does not supply the condition.
When admissibility is the only condition on frameworks, a commitment set is
framework-compatible exactly when it is valid.

## Two Admissible Outcomes

A constructive compatibility theorem and a countermodel showing why a
proposed condition is inadequate are both accepted results.
Neither is treated as a failure of the investigation.

## Classical Propositional Instance

Neutral Substrate's consequence system is abstract and has no vocabularies,
so joint consistency over disjoint vocabularies cannot be stated there.
This theory instantiates it with classical propositional logic.

Every formula is true or false under a valuation, and a theory with no model
entails everything.
Neutral Substrate's abstract consequence system assumes neither.
Results here that use these properties hold for this logic,
not for every consequence system Neutral Substrate allows.

First-order logic with equality is excluded: equality lets theories over
disjoint vocabularies conflict through domain size.

## Referential Fixing Is Not Proved Here

Whether a fragment's commitments are genuinely referential is not established
by this theory.
That is an obligation of the paper and of each realization.

## Identity-Bearing Fragments

Fragments whose commitments assert identity, co-reference, or persistence are
out of scope.

The general individuation and persistence theories do not import this theory
and stay reusable on their own.
If an investigation needs substantive identity criteria, the realization is a
separate downstream construction that imports this theory and the theories it
needs.
That is decided when the need is demonstrated.

## Dependency Direction

This theory depends on Neutral Substrate for the consequence system,
frameworks, admissibility, and framework-compatible commitment sets.
Neutral Substrate does not depend on this theory.
