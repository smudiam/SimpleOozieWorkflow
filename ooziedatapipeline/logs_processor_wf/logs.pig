logs= LOAD '${LOGSPROCESSOR_PIG_INPUTPATH}' USING PigStorage('\t')
as
(logdate:chararray, sessions:int ,   MinimumTotalHeapSize:long,   MaximumTotalHeapSize:long,
           MinimumFreeHeapSize:long ,  MaximumFreeHeapSize:long ,     MinimumUsedHeapSize:long,
          MaximumUsedHeapSize:long,  MinimumMaximumAvailableHeapSize:long ,    MaximumAvailableHeapSize:long);

logs = FOREACH logs GENERATE logdate, sessions ,   MinimumTotalHeapSize,   MaximumTotalHeapSize,
           MinimumFreeHeapSize ,  MaximumFreeHeapSize ,     MinimumUsedHeapSize,
          MaximumUsedHeapSize,  MaximumAvailableHeapSize ;

STORE logs INTO '${LOGSPROCESSOR_PIG_OUTPUTPATH}' ;

