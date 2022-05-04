{{
    config(
        materialized='table',
        transient = false
    )
}}

with tb1 as(
    select * from {{ source('SNOW', 'TB1')}}
)

select * from tb1