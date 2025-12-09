-- 001_initial_schema.sql
-- Initial schema for Ideaction MVP app (users, projects, branding, strategy, content, analytics)

-- Extension for gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

------------------------------------------------------------
-- ENUMS / TYPES
------------------------------------------------------------

-- Status for content items
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'content_status') THEN
        CREATE TYPE content_status AS ENUM (
            'draft',
            'needs_review',
            'approved',
            'scheduled',
            'posted',
            'failed'
        );
    END IF;
END$$;

------------------------------------------------------------
-- CORE TABLES
------------------------------------------------------------

-- Users of the application
CREATE TABLE app_user (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email       TEXT UNIQUE NOT NULL,
    full_name   TEXT NOT NULL,
    timezone    TEXT,
    locale      TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Projects (one per business/brand the user is working on)
CREATE TABLE project (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_user_id   UUID NOT NULL REFERENCES app_user(id) ON DELETE CASCADE,
    name            TEXT NOT NULL,           -- e.g. "Sarah Yoga Coaching"
    description     TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Service description / intake form (1:1 with project)
CREATE TABLE service_description (
    id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id           UUID NOT NULL UNIQUE REFERENCES project(id) ON DELETE CASCADE,

    summary              TEXT NOT NULL,      -- one-line description
    detailed_description TEXT NOT NULL,
    target_audience      TEXT,
    niche                TEXT,
    price_range          TEXT,
    location_type        TEXT CHECK (location_type IN ('online','offline','hybrid')),
    key_benefits         TEXT[],             -- e.g. ["Stress relief","Back pain relief"]
    constraints          TEXT[],             -- e.g. ["Avoid weight loss promises"],

    created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

------------------------------------------------------------
-- BRANDING (Branding Agent output)
------------------------------------------------------------

-- Brand identity map (versioned; full structure saved in jsonb)
CREATE TABLE brand_identity (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id      UUID NOT NULL REFERENCES project(id) ON DELETE CASCADE,
    version         INTEGER NOT NULL,
    is_current      BOOLEAN NOT NULL DEFAULT FALSE,

    brand_name      TEXT NOT NULL,
    tagline         TEXT,
    mission         TEXT NOT NULL,
    values          TEXT[] NOT NULL,         -- quick filterable brand values

    -- Everything else (UVP, toneOfVoice, personas, visualDirection, brandStory, etc.)
    data            JSONB NOT NULL,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT brand_identity_unique_version
        UNIQUE (project_id, version)
);

-- Only one current brand identity per project
CREATE UNIQUE INDEX brand_identity_one_current
    ON brand_identity(project_id)
    WHERE is_current = TRUE;

------------------------------------------------------------
-- MARKETING STRATEGY (Marketing Agent output)
------------------------------------------------------------

-- Marketing strategy (versioned; channels, themes, KPIs in jsonb)
CREATE TABLE marketing_strategy (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id      UUID NOT NULL REFERENCES project(id) ON DELETE CASCADE,
    version         INTEGER NOT NULL,
    is_current      BOOLEAN NOT NULL DEFAULT FALSE,

    overall_goal    TEXT NOT NULL,
    key_messages    TEXT[],
    differentiators TEXT[],

    -- Secondary goals, channel plans, content themes, KPIs, etc.
    data            JSONB NOT NULL,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT marketing_strategy_unique_version
        UNIQUE (project_id, version)
);

-- Only one current strategy per project
CREATE UNIQUE INDEX marketing_strategy_one_current
    ON marketing_strategy(project_id)
    WHERE is_current = TRUE;

------------------------------------------------------------
-- CONTENT (Content Agent output + publishing status)
------------------------------------------------------------

-- Content items (planned posts/emails/etc. with current draft in columns)
CREATE TABLE content_item (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id          UUID NOT NULL REFERENCES project(id) ON DELETE CASCADE,
    marketing_strategy_id UUID REFERENCES marketing_strategy(id) ON DELETE SET NULL,

    scheduled_time      TIMESTAMPTZ,          -- null until scheduled
    channel             TEXT NOT NULL,        -- e.g. "instagram","tiktok","email"
    theme_name          TEXT,                 -- optional link to a theme name in strategy JSON

    status              content_status NOT NULL DEFAULT 'draft',

    -- Current draft fields (produced by content agent, editable by user)
    title               TEXT,
    post_type           TEXT,                 -- e.g. "reel","static_image","email"
    hook                TEXT,
    body                TEXT,
    call_to_action      TEXT,
    hashtags            TEXT[],
    image_description   TEXT,
    notes_for_user      TEXT,

    -- Platform info after publishing
    external_post_id    TEXT,                 -- ID from the social platform

    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

------------------------------------------------------------
-- CONNECTED ACCOUNTS (social integrations)
------------------------------------------------------------

CREATE TABLE connected_account (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id          UUID NOT NULL REFERENCES project(id) ON DELETE CASCADE,

    platform            TEXT NOT NULL,        -- "instagram","tiktok","linkedin", etc.
    display_name        TEXT NOT NULL,        -- "@sarah_yoga"
    account_external_id TEXT NOT NULL,        -- platform-specific ID

    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT connected_account_unique_platform
        UNIQUE (project_id, platform, account_external_id)
);

------------------------------------------------------------
-- ANALYTICS (Analytics Agent output)
------------------------------------------------------------

CREATE TABLE analytics_snapshot (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id      UUID NOT NULL REFERENCES project(id) ON DELETE CASCADE,

    scope           TEXT NOT NULL CHECK (scope IN ('post','account','campaign')),
    platform        TEXT NOT NULL,
    content_item_id UUID REFERENCES content_item(id) ON DELETE SET NULL,

    -- Raw metrics from platforms (structure may vary per platform)
    metrics         JSONB NOT NULL,           -- e.g. {"impressions":1200,"likes":68,...}

    window_start    TIMESTAMPTZ,
    window_end      TIMESTAMPTZ,

    -- Agent-generated interpretation
    analysis_summary    TEXT,
    recommendations     TEXT[],

    created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Helpful index for querying analytics by project/time
CREATE INDEX analytics_snapshot_project_idx
    ON analytics_snapshot(project_id, created_at);
