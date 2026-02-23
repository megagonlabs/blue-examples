# Table description: total row count and list of columns
query_table_desc = """\
SELECT
    (SELECT COUNT(*) FROM {collection}.{entity}) AS total_rows,
    ARRAY_AGG(column_name ORDER BY ordinal_position) AS columns
FROM information_schema.columns
WHERE table_name = '{entity}'
  AND table_schema = '{collection}';
"""

# Basic statistics for numeric columns: count, missing values, unique values, min/max/avg/sum
query_num_basic = """\
SELECT
    COUNT(*) AS total_count,
    COUNT(*) - COUNT({column}) AS missing_{column},
    ROUND(100.0 * (COUNT(*) - COUNT({column})) / COUNT(*), 2) AS missing_pct_{column},
    COUNT(DISTINCT {column}) AS unique_{column},
    MIN({column}) AS min_{column},
    MAX({column}) AS max_{column},
    AVG({column}) AS avg_{column},
    SUM({column}) AS total_{column}
FROM {full_table};
"""

# Frequency distribution for numeric columns: creates 10 bins to show value distribution
query_num_freq = """\
WITH stats AS (
    SELECT
        MIN({column}) AS min_val,
        MAX({column}) AS max_val
    FROM {full_table}
    WHERE {column} IS NOT NULL
),
freq AS (
    SELECT
        CASE 
            WHEN stats.max_val = stats.min_val THEN 1
            ELSE width_bucket({column}, stats.min_val, stats.max_val, 10)
        END AS bin,
        COUNT(*) AS count,
        stats.min_val,
        stats.max_val
    FROM {full_table}, stats
    WHERE {column} IS NOT NULL
    GROUP BY bin, stats.min_val, stats.max_val
)
SELECT
    bin,
    count,
    CASE 
        WHEN max_val = min_val THEN min_val
        ELSE min_val + (bin - 1) * ((max_val - min_val) / 10.0)
    END AS bin_start,
    CASE 
        WHEN max_val = min_val THEN max_val
        ELSE min_val + (bin) * ((max_val - min_val) / 10.0)
    END AS bin_end
FROM freq
ORDER BY bin;
"""

# Basic statistics for ID columns: count, missing values, unique values, min/max (no aggregations)
query_id_basic = """\
SELECT
    COUNT(*) AS total_count,
    COUNT(*) - COUNT({column}) AS missing_{column},
    ROUND(100.0 * (COUNT(*) - COUNT({column})) / COUNT(*), 2) AS missing_pct_{column},
    COUNT(DISTINCT {column}) AS unique_{column},
    MIN({column}) AS min_{column},
    MAX({column}) AS max_{column}
FROM {full_table};
"""

# Basic statistics for categorical columns: count, missing values, unique values
query_category_basic = """\
SELECT
    COUNT(*) AS total_count,
    COUNT(*) - COUNT({column}) AS missing_{column},
    ROUND(100.0 * (COUNT(*) - COUNT({column})) / COUNT(*), 2) AS missing_pct_{column},
    COUNT(DISTINCT {column}) AS unique_{column}
FROM {full_table};
"""

# Frequency distribution for top 20 categorical columns: value counts and percentages, ordered by frequency
query_category_freq_top20 = """\
WITH ranked AS (
    SELECT
        {column},
        COUNT(*) AS cnt
    FROM {full_table}
    GROUP BY {column}
),
total AS (
    SELECT SUM(cnt) AS total_cnt FROM ranked
)
SELECT
    {column},
    cnt AS count,
    cnt * 100.0 / total_cnt AS pct
FROM ranked, total
ORDER BY cnt DESC
LIMIT 20;
"""

# Basic statistics for long text columns: count, missing values, unique values, and text length stats
query_long_basic = """\
SELECT
    COUNT(*) AS total_count,
    COUNT(*) - COUNT({column}) AS missing_{column},
    ROUND(100.0 * (COUNT(*) - COUNT({column})) / COUNT(*), 2) AS missing_pct_{column},
    COUNT(DISTINCT {column}) AS unique_count,
    MIN(LENGTH({column}::text)) AS min_len_{column},
    MAX(LENGTH({column}::text)) AS max_len_{column},
    AVG(LENGTH({column}::text)::numeric) AS avg_len_{column}
FROM {full_table};
"""

# Basic statistics for date/timestamp columns: count, missing values, unique values, min/max dates
query_date_basic = """\
SELECT
    COUNT(*) AS total_count,
    COUNT(*) - COUNT({column}) AS missing_{column},
    ROUND(100.0 * (COUNT(*) - COUNT({column})) / COUNT(*), 2) AS missing_pct_{column},
    COUNT(DISTINCT {column}) AS unique_{column},
    MIN({column}) AS min_{column},
    MAX({column}) AS max_{column}
FROM {full_table};
"""
