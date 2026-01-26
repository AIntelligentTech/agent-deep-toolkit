# Deep Ethics

## Objective

Evaluate and mitigate ethical risks in AI systems and product decisions

## Requirements

# Deep Ethics Workflow

This workflow instructs Cascade to surface and address ethical risks, especially in AI-enabled and data-intensive systems.

## 1. Frame the System and Contexts

- Describe the system or feature:
  - Purpose, capabilities, users, and non-users who may be affected.
- Identify contexts of use:
  - Everyday, high-stakes, vulnerable users, or sensitive domains.
- Note business incentives that might conflict with user or societal interests.

## 2. Identify Stakeholders and Potential Harms

- List stakeholder groups:
  - Direct users, people represented in data, bystanders, and societal groups.
- Brainstorm possible harms:
  - Discrimination, exclusion, misinformation, manipulation, loss of autonomy, safety risks, reputational damage.
- Pay attention to historically marginalized or vulnerable populations.

## 3. Analyze Fairness, Transparency, and Autonomy

- Ask how decisions are made:
  - Human, algorithmic, or mixed; where learning models are used.
- Consider fairness risks:
  - Biased data, proxy variables, unjustified disparities between groups.
- Evaluate transparency and control:
  - Can users understand what the system is doing and why? Can they opt out or contest outcomes?

## 4. Check Legal and Policy Frameworks

- Use the Deep Search (`/deep-search`) workflow to identify applicable laws and policies for the jurisdiction and time (e.g., data protection, AI-specific regulations, consumer protection, sector rules).
- Distinguish between **legal compliance** and **ethical aspiration**:
  - Note where the system might be legal but still ethically questionable.
- Align with internal codes of conduct or responsible AI guidelines if available.

## 5. Design Mitigations and Guardrails

- Propose mitigations at multiple levels:
  - Data collection and labeling, model design, user interface, process and oversight.
- Consider:
  - Consent and choice architectures, explanation mechanisms, rate limits, human review, escalation paths.
- Prefer changes that **reduce systemic risk**, not just surface-level messaging.

## 6. Plan Monitoring, Feedback, and Redress

- Define signals that might indicate ethical problems post-deployment:
  - Complaints, appeals, error reports, watchdog or regulator feedback.
- Ensure there are channels for affected users to raise concerns and seek redress.
- Plan reviews at regular intervals or after significant scope changes.

## 7. Capture the Ethics Assessment

- Summarize ethical issues considered, mitigations chosen, and open questions.
- Document trade-offs and rationales, including what values were prioritized.
- Encourage periodic re-evaluation as norms, laws, and usage patterns evolve.
