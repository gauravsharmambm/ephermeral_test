{{
    config(
        materialized='table',
        transient = false
    )
}}

with tb2 as(
    select * from {{ source('SNOW', 'TB2')}}
)

select * from tb2