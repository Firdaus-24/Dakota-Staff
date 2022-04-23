<%
function GetLastDay(aDate)
    dim intMonth
    dim dteFirstDayNextMonth

    dtefirstdaynextmonth = dateserial(year(adate),month(adate) + 1, 1)
    GetLastDay = Day(DateAdd ("d", -1, dteFirstDayNextMonth))
end function
%>