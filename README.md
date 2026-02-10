# Area-51-Delivery Monorepo

This repository is a Turborepo monorepo containing:

- `apps/web` — public Next.js site
- `apps/admin` — admin Next.js dashboard
- `apps/mobile` — Flutter mobile app
- `packages/*` — shared packages (ui, types, utils, supabase)

Run `pnpm install` at the root, then use `pnpm dev --filter=web` or `pnpm dev --filter=admin` to run apps.
