<!-- #include file='../connection.asp' -->
<% 
dim salary
set salary = Server.CreateObject("ADODB.Command")
salary.activeConnection = mm_cargo_string

salary.CommandText = "SELECT * FROM HRD_T_Salary WHERE year(Sal_startDate) = 2021"
set sal = salary.execute

do until sal.eof 
    salary.commandText = "UPDATE HRD_T_Salary_Convert set Sal_AktifYN = '"& sal("Sal_AktifYN") &"' WHERE Sal_ID = '"& sal("Sal_ID") &"'"
    salary.execute
sal.movenext
loop
Response.Redirect("../dashboard.asp")
 %>