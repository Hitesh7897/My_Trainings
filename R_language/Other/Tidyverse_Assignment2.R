#Basic Sorting Assignments
#1.Sort AE dataset by subject (USUBJID) and AE start date (AESTDTC).


#2.Sort VS dataset by subject and visit (VISITNUM).
#3.Sort LB dataset by test name (LBTEST) alphabetically.
#4.Sort CM dataset by medication start date (CMSTDTC).
#5.Sort EX dataset by treatment start date (EXSTDTC) descending.
#Descending Sorting Assignments
#6.Sort AE dataset by severity (AESEV) with highest severity first.
#7.Sort VS dataset by systolic blood pressure (VSSTRESN) descending.
#8.Sort LB dataset by lab result (LBSTRESN) descending.
#9.Sort CM dataset by medication dose (CMDOSTOT) descending.
#10.Sort EX dataset by dose amount (EXDOSE) descending.
#Multi-Column Sorting
#11.Sort AE dataset by:USUBJID AESTDTC
#12.Sort VS dataset by:USUBJID VISITNUM VSTEST
#13.Sort LB dataset by:LBTEST LBSTRESN descending
#14.Sort CM dataset by:USUBJID CMSTDTC CMENDTC
#15.Sort SV dataset by:USUBJID VISITNUM
#Sorting with Missing Values
#16.Sort AE dataset so that missing AEENDTC appears last.
#17.Sort LB dataset by LBSTRESN, placing missing values first.
#18.Sort VS dataset by VSSTRESN while keeping NA values at the end.
#19.Sort CM dataset by CMENDTC, pushing missing values last.
#20.Sort EX dataset by EXENDTC handling NA properly.
#Sorting with group_by()
#21.Within each subject, sort AE records by AESTDTC.
#22.Within each subject, sort VS records by visit number.
#23.Within each subject, sort LB records by test date.
#24.Within each subject, sort CM records by medication start date.
#25.Within each subject, sort EX records by exposure start date.
#Top Records per Subject
#26.Find the most severe AE per subject.
#27.Find the highest blood pressure per subject in VS.
#28.Find the highest lab result per subject in LB.
#29.Find the latest medication per subject in CM.
#30.Find the latest exposure record per subject in EX.
#Earliest Records per Subject
#31.Find the first AE event per subject.
#32.Find the baseline vital sign record per subject.
#33.Find the first lab test per subject.
#34.Find the first medication per subject.
#35.Find the first exposure record per subject.
#Sorting After Summary
#36.Calculate number of AE events per subject and sort descending.
#37.Calculate average lab value per test and sort descending.
#38.Calculate total drug exposure per subject and sort descending.
#39.Count number of visits per subject and sort descending.
#40.Count number of medications per subject and rank subjects.
#Advanced Real-World Tasks
#41.Find top 10 subjects with highest number of AE events.
#42.Find top 5 highest lab values across all subjects.
#43.Find subjects with longest medication duration.
#44.Sort AE events so that: Fatal events first,Severe events next,Mild events last
#45.Sort VS records so that:
#Screening visits first: Baseline next,Follow-up visits last
#46.Find subjects with earliest treatment start date.
#47.Sort LB records by abnormal flag (LBNRIND) with abnormal results first.
#48.Sort CM dataset so that ongoing medications appear first.
#49.Find top 3 highest systolic BP per subject.
#50.Sort AE dataset by: Serious AE first (AESER == "Y"),Then by severity Then by start date