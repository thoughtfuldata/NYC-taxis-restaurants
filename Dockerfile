FROM mamaya881/csci544:csci544proj as base

COPY poetry.lock pyproject.toml /

FROM base as dev

# pass github secrets & added --mount  uses docker Buildkit cache feature. keeps poetry cache for quick builds but not for final image  
# TODO check to make sure codes speeds up builds
RUN --mount=type=cache,target=/root/.cache/pypoetry/cache \
  --mount=type=cache,target=/root/.cache/pypoetry/artifacts \
  poetry install --no-root

# # needed in case poetry.lock or pyproject.toml is not in the root of the project
# #CMD ["mv" "/app/poetry.lock" "/workspaces/worth/poetry.lock"]

FROM base as prod

# pass github secrets & added --mount  uses docker Buildkit cache feature. keeps poetry cache for quick builds but not for final image  
# TODO check to make sure codes speeds up builds
RUN --mount=type=cache,target=/root/.cache/pypoetry/cache \
  --mount=type=cache,target=/root/.cache/pypoetry/artifacts \
  poetry install --no-root --without test,dev