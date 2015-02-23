# SimpleOozieWorkflow
A simple Oozie workflow for a hadoop data pipeline with MapReduce, Pig and Hive jobs

In real world applications it is hard to achieve end result with one MapReduce(MR) or hive or pig job. It may require multiple MapReduce jobs or a combination of jobs to make data available in multiple places for several applications or users.

For example a MapReduce output may be needed in Hive for Business analysts to run reports; and data may need to be present in mysql or HBase or Mongo for UI. With multiple steps involved in a pipeline like this it is hard to manually keep track of what step is in progress and when to kick off the next step manually. 

Oozie allows us to create a workflow with a sequence of events along with input and output locations of each step, and schedule it to run every 12(or 24) hours.

I am using processlogs map reduce jar, logs.pig script, load_logs_table.sql hive script, input data and workflow-master.xml workflow.

First we need place the MapReduce jar, pig and hive scripts and input data files on to HDFS. We will create an Oozie workflow that calls MapReduce job first and then pig script and hive script in that order with few configuration parameters.

Commands:

hdfs hadoop fs -put /home/cloudera/Downloads/ooziedatapipeline/com.clairvoyant.workshop/workshop-processlogs.jar /user/cloudera/oozie/apps/logs_processor/lib

hdfs hadoop fs -put /home/cloudera/Downloads/logs_processor_wf/workflow-master.xml /user/cloudera/oozie/apps/logs_processor/

hdfs hadoop fs -put /home/cloudera/Downloads/logs_processor_wf/load_temp_logsprocesser_table.sql /user/cloudera/oozie/apps/logs_processor/

hdfs hadoop fs -put /home/cloudera/Downloads/logs_processor_wf/logs.pig /user/cloudera/oozie/apps/logs_processor/

hdfs hadoop fs -put /home/cloudera/Downloads/logs_processor_wf/coordinator /user/cloudera/oozie/apps/logs_processor/

The job.properties file specifies workflow application path on HDFS which is starting point to execute the pipeline.

oozie.wf.application.path=${nameNode}/user/${user}/oozie/apps/logs_processor/workflow-master.xml

Command to run a workflow:

oozie job -oozie http://localhost:11000/oozie -config /home/cloudera/Downloads/ooziedatapipeline/logs_processor_wf/job.properties -run 

