# Research Doubts and Open Questions

This document records the current research assessment,
known limitations, unresolved questions, and safeguards
against overclaiming for this theory.

For the three research criteria, doubt classifications,
status definitions, and procedures, see the
[SE Research Doubts Standard](https://raw.githubusercontent.com/structural-explainability/.github/refs/heads/main/docs/en/research/doubts.md).

## Repository Summary

This assessment is a summary of the present evidence.

| Criterion | Current assessment |
| --------- | ------------------ |
| Mathematical Correctness | Formal results are established under stated hypotheses, for classical propositional logic. They do not hold for every consequence system Neutral Substrate allows. |
| Scientific Adequacy      | Open. Whether a fragment's commitments are genuinely referential, and whether a realization's framework class meets the stated characterization, are obligations of the paper and of each realization. |
| Theoretical Contribution | The proposed contribution is a characterization of when a bounded referential fragment is compatible with a class of interpretive frameworks, including a dichotomy between neutral and conflicting frameworks and the independence of common ground from admissibility alone. No related-work discussion is recorded in this repository. |

The doubts below identify specific issues affecting these assessments.

---

<!-- markdownlint-disable MD024 -->

## Register 1. Doubts About Assumptions (Undermining Doubts)

These questions concern the premises of an argument.
Even if a theorem is correctly proved, can we establish the assumptions necessary to apply it?

### UM-001. (OPEN) Referential Fixing

#### Research criterion

Scientific Adequacy

#### Concern

The results assume a fragment's commitments are referential.

Can a realization establish that?

#### Current Knowledge

Whether a fragment's commitments are genuinely referential is not established by this theory.

See [DECISIONS.md](DECISIONS.md#referential-fixing-is-not-proved-here).

#### Remaining Work

The paper and each realization must justify it.

### UM-002. (OPEN) Framework Class Characterization

#### Research criterion

Scientific Adequacy

#### Concern

The compatibility result depends on how the framework class is characterized.

#### Current Knowledge

The class is characterized by what a framework permits on the fragment's vocabulary.
The characterization never mentions the fragment's commitments, since that would make the result true by definition.
Admissibility alone does not supply the condition: `compatible_bare_iff_valid` shows that under bare admissibility a commitment set is framework-compatible exactly when it is valid.

See [DECISIONS.md](DECISIONS.md#characterizing-the-framework-class-independently).

#### Remaining Work

A realization must justify that its framework class meets the characterization.

### UM-003. (OPEN) Satisfiable, Nontrivial, Bounded Fragments

#### Research criterion

Mathematical Correctness

#### Concern

The results apply only to fragments with certain properties.

#### Current Knowledge

A fragment must be satisfiable, nontrivial, and bounded.
A valid commitment set is compatible with every satisfiable framework, so a result about it would say nothing.
`not_compatible_bare_of_nontrivial` covers the nontrivial case under bare admissibility.

See [DECISIONS.md](DECISIONS.md#fragment-relative-common-ground).

#### Remaining Work

A realization must show its fragment meets these conditions.

### UM-004. (OPEN) Dependence on the Logic

#### Research criterion

Mathematical Correctness

#### Concern

Do the results transfer to other consequence systems?

#### Current Knowledge

The theory instantiates Neutral Substrate's abstract consequence system with classical propositional logic.
Results that use its properties hold for this logic, not for every consequence system Neutral Substrate allows.
First-order logic with equality is excluded: equality lets theories over disjoint vocabularies conflict through domain size.

See [DECISIONS.md](DECISIONS.md#classical-propositional-instance).

#### Remaining Work

None recorded beyond stating the logic with each result.

## Register 2. Doubts About Conclusions (Rebutting Doubts)

These questions concern whether a claimed conclusion is false.
For example, a counterexample satisfying all the premises
but violating the conclusion would challenge the claimed theorem or its formalization.
A model that violates a required assumption does not
necessarily refute a conditional theorem.
If a counterexample is found,
we must identify the exact claim it challenges and
whether its assumptions are satisfied.

**None currently identified.**

## Register 3. Doubts About What Our Results Mean (Undercutting Doubts)

These questions concern the connection
between a formal theorem and the scientific claim made about it.
A theorem may be correct while its informal interpretation is too strong.
Some of these doubts are addressed by permanent documentation
rules rather than additional proofs.

### UC-001. (STANDING RULES) Fragment-Relative Results

#### Research criterion

Scientific Adequacy

#### Concern

A reader might read a fragment result as a result for the full class of admissible frameworks.

#### Current Knowledge

Results hold for a stated referential fragment and a stated class of frameworks.
They neither assert nor weaken Neutral Substrate's `ReferentialCommonGround`.

#### Standing Rules

1. State the fragment and framework class with every result.
2. Do not cite a result as asserting or weakening `ReferentialCommonGround`.

### UC-002. (STANDING RULES) Identity-Bearing Fragments

#### Research criterion

Scientific Adequacy

#### Concern

A reader might apply the results to fragments whose commitments assert identity.

#### Current Knowledge

Fragments whose commitments assert identity, co-reference, or persistence are out of scope.
A realization needing substantive identity criteria is a separate downstream construction.

See [DECISIONS.md](DECISIONS.md#identity-bearing-fragments).

#### Standing Rules

1. Do not apply these results to identity-bearing fragments.

<!-- markdownlint-enable MD024 -->
