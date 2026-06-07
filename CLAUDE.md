# PEON Wartable Guide

This repo owns container image definitions used by PEON game deployments.

## Scope

- Image build script: `build_containers`
- Image definitions: `containers/`
- Current container families include `steamcmd/`, `steamcmd-proton/`, and `steamcmd-wine/`

## Working Rules

1. Start from the specific image directory under `containers/`.
2. Treat image names, entrypoints, environment variables, and mounted init assets as contract points for downstream repos.
3. Review whether plan modes or image names in `peon-warplans/` rely on the image being changed.
4. Do not push or overwrite remote images unless the user explicitly asked for that release action.
5. If runtime behavior changes, update `peon-docs/` source docs.

## Commands

Static review is preferred first. The repo-level build entrypoint is:

```bash
cd /home/richard/development/peon-wartable
./build_containers <version>
```

Treat that as a release-oriented action, not default validation.

## Important Files

- Build/push script: `build_containers`
- Image definitions: `containers/steamcmd/`, `containers/steamcmd-proton/`, `containers/steamcmd-wine/`
- Example image definition: `containers/steamcmd/Dockerfile`

## Validation Expectations

- Prefer static Dockerfile review and narrow image-surface inspection first.
- If executable validation is required, use the smallest local Docker build path that matches the task.
- Avoid pushing images unless explicitly requested.

## Cross-Repo Dependencies

- `peon-warplans` references image names and modes that depend on this repo
- `peon-orc` relies on compatible image behavior at runtime
- `peon-docs` should reflect meaningful image/runtime behavior changes

## Default Workflow

1. Identify the affected container family.
2. Read the Dockerfile and adjacent init/tools files.
3. Make the smallest packaging change needed.
4. Validate with static review or a narrow Docker check.
5. Update docs if behavior changed.