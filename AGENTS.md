# Codex Configuration — SwiftUI App

## Goal
Create a modern iOS application using SwiftUI with clean architecture, maintainable structure, and production-ready patterns.

## General Requirements
- Use **SwiftUI** as the primary UI framework
- Target latest stable iOS version (fallback gracefully if needed)
- Follow **modern Apple development practices**
- Prefer **composition over inheritance**
- Keep code readable, modular, and testable

## Architecture
- Use **MVVM** (or a lightweight variation if more suitable)
- Separate concerns:
  - UI (Views)
  - State / Logic (ViewModels)
  - Data layer (Services / Repositories)
- Avoid massive views or view models

## UI & UX
- Follow **Apple Human Interface Guidelines**
- Support:
  - Dark Mode
  - Dynamic Type
  - Accessibility (VoiceOver basics)
- Use native components unless customization is clearly beneficial

## State Management
- Prefer:
  - `@State`, `@StateObject`, `@ObservedObject`
  - `@EnvironmentObject` only when justified
- Avoid overusing global state

## Networking & Data
- Use async/await for asynchronous operations
- Keep networking layer abstracted
- Make models Codable when applicable

## Testing
- Include:
  - Basic unit tests for ViewModels
- Keep logic testable (avoid tight coupling with UI)

## Installed Skills
- Detect and use any **available installed skills/tools/plugins**
- Prefer existing tools over reimplementing functionality
- Integrate them in a clean and minimal way

## Code Style
- Use clear naming
- Avoid unnecessary comments
- Keep functions small and focused
- Prefer Swift idioms over generic patterns

## Output Expectations
- Provide:
  - Project structure
  - Key files with explanations
- Do NOT generate unnecessary boilerplate
- Keep implementation concise but realistic

## Constraints
- Avoid:
  - UIKit unless absolutely necessary
  - Over-engineering
  - Premature optimization

## Optional Enhancements
- If relevant, suggest:
  - Dependency injection approach
  - Simple theming system
  - Reusable components

---

**Instruction to Codex:**
Generate the project step-by-step, explaining key decisions briefly. Prioritize clarity and maintainability over completeness.