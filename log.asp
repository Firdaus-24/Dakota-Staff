<%
Set fs=Server.CreateObject("Scripting.FileSystemObject")

filename = "d:\newsite\hrd\log\" & right("00" & month(now()),2) & right("00" & day(now()),2) & right(year(now()),2) & ".txt"
'response.write filename & "<BR>"
'Set f=fs.OpenTextFile(Server.MapPath("/hrd/log/test.txt"), 1)
if fs.FileExists(filename) then
	set F =fs.OpenTextFile(filename,8,true)
		'x=F.ReadAll
		't.close
		'Response.Write x
		
			'if f.AtEndOfStream = True then
		f.writeLine("add update on " & now())
			'end if
		f.close	
		
else	
	response.write "no file"
	set F = fs.CreateTextFile(filename,true)
	f.WriteLine("update on " & now())
	f.close	
end if

Set f=Nothing
Set fs=Nothing
%>

