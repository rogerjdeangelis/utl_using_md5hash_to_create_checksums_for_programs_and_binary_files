Using_md5hash_to_create_checksums_for_programs_and_binary_files

Problem: Create and check checksums for binary or text files

see SAS  Forum
https://tinyurl.com/ybn9yyn7
https://communities.sas.com/t5/SAS-Programming/How-would-I-do-a-checksum-of-a-SAS-program-code-file/m-p/490234

INPUT
=====

 SAS Program(to check) and the corresponding md5 hash

  d:/txt/utl_using_md5hash_to_create_checksums_for_programs_and_binary_files.sas

  and md5 hash

  %let md5hash=fbf4570642e73b4ac46c77a16101b187;


 EXAMPLE OUTPUT LOG
 ==================

   CHECKSUMS MATCH

  or

   CHECKSUMS DO NOT MATCH


PROCESS
=======

%let checksum =fbf4570642e73b4ac46c77a16101b187;

data _null_;

  status="&checksum";

  rc=dosubl('
     %utl_submit_r64(resolve(''
       library(tools);
       status<-md5sum("d:/txt/utl_using_md5hash_to_create_checksums_for_programs_and_binary_files.sas");
       writeClipboard(status);
     ''),returnvar=status);
  ');

  if symget('status') = status them put "CheckSums Match        ";
  else put "CheckSums Do Not Match";

stop;
run;quit;


OUTPUT SAS LOG
==============

  CHECKSUMS MATCH

 or

  CHECKSUMS DO NOT MATCH

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data _null_;
  file "d:/txt/utl_using_md5hash_to_create_checksums_for_programs_and_binary_files.sas";
  input;
  put _infile_;
cards4;
%macro ls40 / cmd
   des="list 40 obs from the last dataset";
   /* i put this on shift right mouse button */
   note;notesubmit '%ls40a;';
   run;
%mend ls40;
%macro ls40a /cmd des="Print 40 obs from table";
  dm "out;clear;";
  %utlfkil("%sysfunc(pathname(work))/__dm.txt");
  footnote;
  options nocenter;
  proc printto print="%sysfunc(pathname(work))/__dm.txt";
  proc sql noprint;select put(count(*),comma18.) into :tob  separated by ' '
      from _last_;quit;
  title "Up to 40 obs %upcase(%sysfunc(getoption(_last_))) total obs=&tob";
  proc print data=_last_ ( Obs= 40 ) /*width=full*/ width=min uniform  heading=horizontal;
     format _all_;
  run;quit;
  proc printto;
  run;quit;
  title;
  filename __dm clipbrd ;
  data _null_;file _dm; put "";run;quit;
  data _null_;
     infile "%sysfunc(pathname(work))/__dm.txt" end=dne;
     input;
     file __dm ;
     put _infile_;
     file print;
     put _infile_;
  run;quit;
  filename __dm clear;
  run;quit;
  title;
  dm "out;";
%mend ls40a;
;;;;
run;quit;


