
<%
	Set Upload = Server.CreateObject("Persits.Upload.1")

	Upload.OverwriteFiles = False
	On Error Resume Next

	Upload.SetMaxSize 1048576	' Limit files to 1MB
	Count = Upload.Save("c:\upload")
%>
<HTML>
<BODY BGCOLOR="#FFFFFF">
<CENTER>

<% If Err <> 0 Then %>

	<FONT SIZE=3 FACE="Arial" COLOR=#0020A0>
	<H3>The following error occured while uploading:</h3>
	</FONT>

	<FONT SIZE=3 FACE="Arial" COLOR=#FF2020>
	<h2>"<% = Err.Description %>"</h2>
	</FONT>

	<FONT SIZE=2 FACE="Arial" COLOR="#0020A0">
	Please <A HREF="demo1.asp">try again</A>.
	</FONT>

<% Else %>
<FONT SIZE=3 FACE="Arial" COLOR=#0020A0>
<h2>Success! <% = Count %> file(s) have been uploaded.</h2>
</FONT>

<FONT SIZE=3 FACE="Arial" COLOR=#0020A0>
<TABLE BORDER=1 CELLPADDING=3 CELLSPACING=0>
<TH BGCOLOR="#FFFF00">Uploaded File</TH><TH BGCOLOR="#FFFF00">Size</TH><TH BGCOLOR="#FFFF00">Original Size</TH><TR>
<% For Each File in Upload.Files %>
	<% If File.ImageType = "GIF" or File.ImageType = "JPG" or File.ImageType = "PNG" Then %>
		<TD ALIGN=CENTER>
			<IMG SRC="/uploaddir/<% = File.FileName%>"><BR><B><% = File.OriginalPath%></B><BR>
			(<% = File.ImageWidth %> x <% = File.ImageHeight %> pixels)
		
		</TD>
	<% Else %>
		<TD><B><% = File.OriginalPath %></B></TD>
	<% End If %>
	<TD ALIGN=RIGHT VALIGN="TOP"><% =File.Size %> bytes</TD>
	<TD ALIGN=RIGHT VALIGN="TOP"><% =File.OriginalSize %> bytes</TD><TR>
<% Next %>
</TABLE>
</FONT>
<P>
<FONT SIZE=2 FACE="Arial" COLOR=#0020A0>
Click <A HREF="demo1.asp">here</A> to upload more files.
</FONT>
<% End If %>

<HR>
<FONT SIZE=2 FACE="Arial" COLOR=#0020A0>
<A HREF="http://www.persits.com/aspupload.exe">Download</A> your trial copy of AspUpload.
</FONT>



</CENTER>
</BODY>
</HTML>