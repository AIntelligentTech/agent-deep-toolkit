---
name: simplify
description: Reduce complexity without changing behavior - architectural and cognitive simplification
command: /simplify
aliases: ["/reduce-complexity", "/declutter"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Simplify Workflow

This workflow instructs Cascade to reduce complexity systematically, going beyond refactoring to achieve fundamental simplification.

## 1. Understand Current Complexity

- Measure complexity indicators:
  - Lines of code, cyclomatic complexity.
  - Number of files, modules, dependencies.
  - Depth of inheritance, coupling between components.
- Identify complexity symptoms:
  - Hard to understand or explain.
  - Frequent bugs in certain areas.
  - Long onboarding time for new developers.

## 2. Map Complexity Sources

Identify where complexity lives:

- **Unnecessary abstraction**: Layers that don't add value.
- **Premature generalization**: Flexibility nobody uses.
- **Historical cruft**: Code for obsolete requirements.
- **Accidental complexity**: Poor structure, not inherent difficulty.
- **Over-engineering**: Handling hypothetical cases.

## 3. Apply Simplification Principles

### Remove What's Not Needed
- Delete dead code.
- Remove unused features.
- Eliminate redundant abstractions.

### Consolidate What's Scattered
- Merge similar concepts.
- Reduce the number of moving parts.
- Centralize related logic.

### Flatten What's Too Deep
- Reduce inheritance hierarchies.
- Simplify deeply nested structures.
- Favor composition over inheritance.

### Inline What's Over-Abstracted
- Bring together what was artificially separated.
- Reduce indirection.
- Make code paths more obvious.

## 4. Simplify Interfaces

- Reduce API surface area.
- Make defaults do the right thing.
- Hide complexity from consumers.
- Provide good error messages.

## 5. Simplify Data Structures

- Use simpler data representations.
- Eliminate unnecessary normalization.
- Reduce state that needs to be tracked.
- Make state transitions explicit.

## 6. Simplify Flow Control

- Reduce conditional complexity.
- Make happy paths obvious.
- Handle errors consistently.
- Eliminate unnecessary async.

## 7. Simplify Dependencies

- Reduce external dependencies.
- Replace complex libraries with simpler solutions.
- Consider building vs buying trade-offs.

## 8. Validate Simplification

- Verify behavior is unchanged.
- Confirm complexity metrics improved.
- Get feedback from team:
  - Is it easier to understand?
  - Is it easier to modify?
- Ensure tests still pass.

## 9. Prevent Complexity Creep

- Document why things are now simple.
- Add lint rules or architecture tests.
- Review PRs for unnecessary complexity.
- Regularly revisit and simplify.
