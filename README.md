# SimpleOozieWorkflow
A simple Oozie workflow for a hadoop datapipeline with MapReduce, Pig and Hive jobs

In real world applications it is hard to achieve end result with one MapReduce(MR) or hive or pig job. It may require multiple mapreduce jobs or a combination of jobs to make data available in multiple places for several applications or users.

For example  a MapReduce output may be needed in Hive for Business analysts to peform queries or data may need to be present in mysql or HBase or Mongo to wire up UI for transactions. With multiple steps involved in a pipeline like this it is hard for someone to manually keep track of what step is in progress and when to kick off the next step manually. 

So we will create an Oozie workflow with a sequence of events in the pipeline along with input and output locations of each step, and schedule it to run every 12(or 24) hours.

I am using processlogs map reduce jar, logs.pig script, load_logs_table.sql hive script, input data and workflow-master.xml workflow.

First We need to place the MR jar, pig and hive scripts and input data files on to HDFS. We will create an Oozie workflow that calls MR job first and then pig script and hive script in that order with few configuration parameters.

sudo -su hdfs hadoop fs -put /home/cloudera/Downloads/ooziedatapipeline/com.clairvoyant.workshop/workshop-processlogs.jar /user/cloudera/oozie/apps/logs_processor/lib
sudo -su hdfs hadoop fs -put /home/cloudera/Downloads/logs_processor_wf/workflow-master.xml /user/cloudera/oozie/apps/logs_processor/
sudo -su hdfs hadoop fs -put /home/cloudera/Downloads/logs_processor_wf/load_temp_logsprocesser_table.sql /user/cloudera/oozie/apps/logs_processor/
sudo -su hdfs hadoop fs -put /home/cloudera/Downloads/logs_processor_wf/logs.pig /user/cloudera/oozie/apps/logs_processor/
sudo -su hdfs hadoop fs -put /home/cloudera/Downloads/logs_processor_wf/coordinator /user/cloudera/oozie/apps/logs_processor/

A job.properties file specifies workflow application path on HDFS to execute the job.
oozie.wf.application.path=${nameNode}/user/${user}/oozie/apps/logs_processor/workflow-master.xml

command to run a workflow:
oozie job -oozie http://localhost:11000/oozie -config /home/cloudera/Downloads/ooziedatapipeline/logs_processor_wf/job.properties -run  

We will have to delete  any _SUCCESS flag or logs created in the output of any job before we feed that folder as input data to subsequent jobs. These preprocessing steps can be actions in the workflow.

