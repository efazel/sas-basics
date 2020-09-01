*import csv files ;
proc import datafile = '/folders/myfolders/cert/boot.csv'
	out=shoes
	dbms=csv
	replace;
	getnames=no;
run;

data boots;
	set shoes;
	where var1='South America' OR var1='Canada';
run;

*libname cert '/folder/myfolders/cert';
libname Men50 '/folders/myfolders/cert/Men50';
data Men50.males;
	set cert.admit;
	where sex='M' and age>50;
run;

* Import excel file. create permanent library certxl;
libname certxl XLSX '/folders/myfolders/cert/exercise.xlsx';
data work.stress(drop=ActLevel);
	set certxl.activitylevels;
	where ActLevel = 'HIGH';
run;
proc contents data=work.stress;
run;

*reading excel worksheet using name literals;
libname certxl XLSX '/folders/myfolders/cert/stock.xlsx';
data work.bstock;
	set certxl.'boots stock'n;
run;

* Import excel file. create permanent library certxl and print the results;
libname certxl XLSX '/folders/myfolders/cert/exercise.xlsx';
data work.stress(drop=HIGH);
	set certxl.activitylevels;
	where ActLevel = 'HIGH';
run;
proc print data=work.stress;
run;

* create excel files;
libname excelout xlsx 'XXX';
data excelout.HighStress;
	set cert.stress;
run;

* write observation explicitly;
data certXL.obs_output;
	set certxl.Activitylevels;
	if _n_ = 5 then output;
run;
proc print data=certxl.obs_output;
run;
