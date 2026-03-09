#Assignment
#==========
#Given the below datasets

install.packages("tidyverse")
install.packages("haven")
library("tidyverse")
library("haven")

AE<-read_csv("https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/ae.csv")
DM<-read_csv("https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/dm.csv")
VS<-read_csv("https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/vs.csv")
EX<-read_csv("https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/ex.csv")
LB<-readr::read_csv("https://raw.githubusercontent.com/ganeshbabuNN/datasets/master/clinical_datasets/sdtm/daibetes/csv/lb.csv")
SV<-read_csv("https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/sv.csv")
CM<-read_csv("https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/cm.csv")
DS<-read_csv("https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/ds.csv")

#if the above URL does not work... test if the URL is reachable 
url <- "https://raw.githubusercontent.com/ganeshbabuNN/datasets/master/clinical_datasets/sdtm/daibetes/csv/lb.csv"
readLines(url, n = 5)
#If you still get an error (Corporate proxy / SSL)
LB <- readr::read_csv(curl::curl(url))
LB <- readr::read_csv(
  url,
  locale = readr::locale(encoding = "UTF-8")
)

#Select Core Identifiers from Any Domain

AE %>% select(STUDYID, DOMAIN, USUBJID)

#Select All AE Variables from AE 

AE %>% select(everything())

#Select All Date Variables

AE %>% select(contains("DTC", ignore.case = FALSE))

#Select Only Weight and Height from VS

##By test name pattern

VS %>% glimpse()

VS %>% select(everything()) %>% filter(VSTESTCD %in% c("HEIGHT", "WEIGHT"))

#Select All Result Columns from LB 'LBOR','LBST'

LB %>%  glimpse()

LB %>% select(starts_with("LBOR"), starts_with("LBST"))

#Select All Result Columns from LB 'DY','DTC'

LB %>% select(contains("DY"), contains("DTC"))

#Select All Character Columns (Metadata Review)

LB %>% select(where(is.character))

#Select All Numeric Result Variables

LB %>% select(where(is.numeric))

#Select All Variables for Exposure (EX)

EX %>% glimpse()

EX %>% select(everything())

#Select All Timing Variables i,e DTC,DY

EX %>% select(contains("DY"), contains("DTC"))

#Select All Qualifiers in a Domain ,Only AE-specific columns

AE %>% select(starts_with("AE"))

#Reorder: Put Keys First STUDYID, DOMAIN, USUBJID, AESEQ

AE %>% glimpse()
AE %>% select(STUDYID, DOMAIN, USUBJID, AESEQ, everything())

#Select All "Standardized" Variables like LBSTRESC,LBSTRESN,LBSTRESU

LB %>% select(contains("LBSTR"))
LB %>% select(starts_with("LBSTR"))


#Select All Test Codes like VSTESTCD,VSTEST

VS %>% select(contains("TEST"))
                                                  
#Select All Numeric Measurements + Subject ID

VS %>%  glimpse()
VS %>% select(where(is.numeric), USUBJID)

# Note : SUBJID does not exist in the VS dataset


#Select Variables Using Regex (Advanced) using RES,RESN,RESC

VS %>%select(matches("RES"))

#Programmatic SDTM Selection putting a vector c("USUBJID", "AETERM", "AEDECOD", "AESTDTC", "AEENDTC")

vec <- c("USUBJID", "AETERM", "AEDECOD", "AESTDTC", "AEENDTC")
AE %>% select(all_of(vec))

#Select Only Domain-Specific Columns

AE %>%select(contains("AE"))
CM %>%select(contains("CM"))
DM %>%  select(contains("DM"))
DS %>%  select(contains("DS"))
EX %>%  select(contains("EX"))
LB %>% select(contains("LB"))
SV %>%  select(contains("SV"))
VS %>% select(contains("VS"))

#Typical SDTM Validation Check 

##Are all date variables present?

AE %>% select(grep("DTC$", names(AE)))

##Are all sequence variables present?

AE %>% select(matches("SEQ"))

AE %>%glimpse()

##Are all date variables present?

AE %>% select(contains("DTC"))

##Are all sequence variables present?

AE %>% select(matches("SEQ"))
