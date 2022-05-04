{{ config(
    post_hook=[
      "alter table union_db.dbt_gsharma.union_tb cluster by (DOB)"
    ]
) }}

with all_records as (
    select name, max(age) as max_stg_load_dtm
    from {{ ref('tb1_dbt') }} 
    group by name
),
deleted_records as(
    select name 
    from {{ ref('tb1_dbt') }}
    where name not in 
    (select distinct name from {{ ref('tb1_dbt') }})
),
current_records as(
    select * 
    from all_records
    where name not in (select name from deleted_records)
),
final as(
    select tb.* 
    from {{ ref('tb1_dbt') }} tb
    join current_records 
        on tb.name = current_records.name
)

select * from final