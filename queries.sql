select * from combined_big_mac_table
select * from combined_macro_economic_indicators_table_daily
select * from aggregated_macro_economic_indicators_table_monthly

-- JOIN
select m.date, m.inrusd, bm.date, bm.bigmac_inrusd from aggregated_macro_economic_indicators_table_monthly m, combined_big_mac_table bm 
where m.date = bm.date;

-- CREATE A TABLE FOR TARGETED ANALYSIS
create table India as 
	select m.date, m.inrusd, bm.bigmac_inrusd from aggregated_macro_economic_indicators_table_monthly m, combined_big_mac_table bm 
	where m.date = bm.date;

alter table India add column over_under_valued1 varchar(30);
select * from India;

UPDATE India
SET over_under_valued = 'OVER'
WHERE inrusd > bigmac_inrusd;

UPDATE India
SET over_under_valued = 'UNDER'
WHERE inrusd < bigmac_inrusd;

select * from India;
