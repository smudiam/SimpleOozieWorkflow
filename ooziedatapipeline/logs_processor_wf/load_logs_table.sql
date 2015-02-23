use default;
CREATE TABLE IF NOT EXISTS logs_processor(
      logdate STRING,sessions INT, MinimumTotalHeapSize BIGINT,   MaximumTotalHeapSize BIGINT,
           MinimumFreeHeapSize BIGINT ,  MaximumFreeHeapSize BIGINT ,     MinimumUsedHeapSize BIGINT,
          MaximumUsedHeapSize BIGINT,  MaximumAvailableHeapSize BIGINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION 'hdfs://quickstart.cloudera/user/cloudera/oozie/apps/logs_processor/data/logs_processor';


LOAD DATA INPATH 'hdfs://quickstart.cloudera/user/cloudera/workshop/data/output/processlogs/pigoutput' OVERWRITE INTO TABLE logs_processor;





