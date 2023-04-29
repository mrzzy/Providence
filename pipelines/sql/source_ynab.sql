--
-- Providence
-- Pipelines
-- YNAB External Table DDL
--
CREATE EXTERNAL TABLE {{ params.redshift_external_schema }}.{{ params.redshift_table }} (
  data struct<budget:struct<id:varchar,name:varchar,last_modified_on:varchar,date_format:struct<format:varchar>,currency_format:struct<iso_code:varchar,example_format:varchar,decimal_digits:int,decimal_separator:varchar,symbol_first:boolean,group_separator:varchar,currency_symbol:varchar,display_symbol:boolean>,first_month:varchar,last_month:varchar,accounts:array<struct<id:varchar,name:varchar,type:varchar,on_budget:boolean,closed:boolean,note:varchar,balance:int,cleared_balance:int,uncleared_balance:int,transfer_payee_id:varchar,direct_import_linked:boolean,direct_import_in_error:boolean,last_reconciled_at:varchar,debt_original_balance:varchar,debt_interest_rates:varchar,debt_minimum_payments:varchar,debt_escrow_amounts:varchar,deleted:boolean>>,payees:array<struct<id:varchar,name:varchar,transfer_account_id:varchar,deleted:boolean>>,payee_locations:array<struct<id:varchar,payee_id:varchar,latitude:varchar,longitude:varchar,deleted:boolean>>,category_groups:array<struct<id:varchar,name:varchar,hidden:boolean,deleted:boolean>>,categories:array<struct<id:varchar,category_group_id:varchar,name:varchar,hidden:boolean,original_category_group_id:varchar,note:varchar,budgeted:int,activity:int,balance:int,goal_type:varchar,goal_day:varchar,goal_cadence:int,goal_cadence_frequency:int,goal_creation_month:varchar,goal_target:int,goal_target_month:varchar,goal_percentage_complete:int,deleted:boolean>>,months:array<struct<month:varchar,note:varchar,income:int,budgeted:int,activity:int,to_be_budgeted:int,age_of_money:int,deleted:boolean,categories:array<struct<id:varchar,category_group_id:varchar,name:varchar,hidden:boolean,original_category_group_id:varchar,note:varchar,budgeted:int,activity:int,balance:int,goal_type:varchar,goal_day:varchar,goal_cadence:int,goal_cadence_frequency:int,goal_creation_month:varchar,goal_target:int,goal_target_month:varchar,goal_percentage_complete:int,deleted:boolean>>>>,transactions:array<struct<id:varchar,date:varchar,amount:int,memo:varchar,cleared:varchar,approved:boolean,flag_color:varchar,account_id:varchar,payee_id:varchar,category_id:varchar,transfer_account_id:varchar,transfer_transaction_id:varchar,matched_transaction_id:varchar,import_id:varchar,import_payee_name:varchar,import_payee_name_original:varchar,debt_transaction_type:varchar,deleted:boolean>>,subtransactions:array<struct<id:varchar,transaction_id:varchar,amount:int,memo:varchar,payee_id:varchar,category_id:varchar,transfer_account_id:varchar,deleted:boolean>>,scheduled_transactions:array<struct<id:varchar,date_first:varchar,date_next:varchar,frequency:varchar,amount:int,memo:varchar,flag_color:varchar,account_id:varchar,payee_id:varchar,category_id:varchar,transfer_account_id:varchar,deleted:boolean>>,scheduled_subtransactions:array<varchar>>,server_knowledge:int>,
  _rest_api_src_scraped_on varchar
)
ROW FORMAT
  SERDE 'org.openx.data.jsonserde.JsonSerDe'
  STORED AS TEXTFILE
    LOCATION 's3://{{ params.s3_bucket }}/providence/grade=raw/source=ynab/'
