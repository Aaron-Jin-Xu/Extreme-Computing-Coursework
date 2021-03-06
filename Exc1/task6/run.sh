#!/bin/bash

output="/user/s1673820/assignment1/task6"
my_home="/afs/inf.ed.ac.uk/user/s16/s1673820"
hdfs dfs -test -d $output
if (($?==0));then
    hdfs dfs -rm -r $output
fi
hadoop jar /opt/hadoop/hadoop-2.7.3/share/hadoop/tools/lib/hadoop-streaming-2.7.3.jar \
    -D mapred.job.name='JinXTask6' \
    -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
    -D num.key.fields.for.partition=2 \
    -D stream.num.map.output.key.fields=3 \
    -D mapreduce.partition.keypartitioner.options=-k1,2 \
    -D mapreduce.partition.keycomparator.options="-k1 -k2 -k3" \
    -input /user/s1673820/assignment1/task4/* \
    -output /user/s1673820/assignment1/task6 \
    -mapper mapper.py \
    -file $my_home/Assignment/Exc1/task6/mapper.py \
    -reducer reducer.py \
    -file $my_home/Assignment/Exc1/task6/reducer.py \
    -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner

hdfs dfs -cat /user/s1673820/assignment1/task6/* | head -n 20 > $my_home/Assignment/Exc1/task6/output.out
