
<% option explicit 
Response.Expires = -1
Server.ScriptTimeout = 50000
%>


	<!--#include file="../uploadfile.asp" -->
	<!-- #include file="../../Connections/cargo.asp" -->
	<!-- #include file='../root.asp' -->
<%
	Dim uploadsDirVar
	uploadsDirVar = "D:\newsite\hrd\importFile\"
	'uploadsDirVar = "D:\newsite\trial\csvdata\"

	function OutputForm()
	
	end function

	function TestEnvironment()
		Dim fso, fileName, testFile, streamTest
		TestEnvironment = ""
		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		if not fso.FolderExists(uploadsDirVar) then
			TestEnvironment = "<B>Folder " & uploadsDirVar & " does not exist.</B><br>"
			exit function
		end if
		fileName = uploadsDirVar & "\test.txt"
		on error resume next
		Set testFile = fso.CreateTextFile(fileName, true)
		If Err.Number<>0 then
			TestEnvironment = "<B>Folder " & uploadsDirVar & " does not have write permissions.</B><br>The value of your uploadsDirVar is incorrect. Open uploadTester.asp in an editor and change the value of uploadsDirVar to the pathname of a directory with write permissions."
			exit function
		end if
		Err.Clear
		testFile.Close
		fso.DeleteFile(fileName)
		If Err.Number<>0 then
			TestEnvironment = "<B>Folder " & uploadsDirVar & " does not have delete permissions</B>, although it does have write permissions.<br>Change the permissions for IUSR_<I>computername</I> on this folder."
			exit function
		end if
		Err.Clear
		Set streamTest = Server.CreateObject("ADODB.Stream")
		If Err.Number<>0 then
			TestEnvironment = "<B>The ADODB object <I>Stream</I> is not available in your server.</B><br>Check the Requirements page for information about upgrading your ADODB libraries."
			exit function
		end if
		Set streamTest = Nothing
	end function

	function SaveFiles
		Dim Upload, fileName, fileSize, ks, i, fileKey, b


		Set Upload = New FreeASPUpload
		Upload.Save(uploadsDirVar) 
		

		' If something fails inside the script, but the exception is handled
		If Err.Number<>0 then Exit function

		SaveFiles = ""
		ks = Upload.UploadedFiles.keys
		if (UBound(ks) <> -1) then
			
			SaveFiles = "<B>Files uploaded Success : </B> "
			for each fileKey in Upload.UploadedFiles.keys
				SaveFiles = SaveFiles & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & "B) "
				response.Redirect("p_index.asp?sFileName="&Upload.UploadedFiles(fileKey).FileName)
			next
		else
			SaveFiles = "The file name specified in the upload form does not correspond to a valid file in the system."
		end if
		
		
		
	end function

%>




<html>
	<title>IMPORT FILE</title>
<head>
	<meta name="viewport" content="width=device-width">
	
	<link rel="stylesheet" type="text/css" href="css/style_t.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/styletable.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/properti.css"/> <!-- CSS All -->
	<link rel="stylesheet" type="text/css" href="css/grid.css"/> <!-- CSS All -->
	<link href="css/mobile_t.css" rel="stylesheet" type="text/css" media="only screen and (max-width:360px)"> 
	<link href="css/menu_t.css" rel="stylesheet" type="text/css" media="only screen and (min-width:769px)">
	<!-- Tambahan -->
	<link rel="stylesheet" type="text/css" href="css/tcal.css" />
	<script type="text/javascript" src="../js/jquery-1.4.min.js"></script>
	<script type="text/javascript" src="../js/jquery-ui-1.8.min.js"></script>
	<script type="text/javascript" src="../js/tcal.js"></script>


	<script>
	function onSubmitForm(objForm) {
		var formDOMObj = document.frmSend;
		var arrExtensions=new Array("csv");
		var objInput = objForm.elements["filter"];
		var strFilePath = objInput.value;
		var arrTmp = strFilePath.split(".");
		var strExtension = arrTmp[arrTmp.length-1].toLowerCase();
		var blnExists = false;
		
		
		for (var i=0; i<arrExtensions.length; i++) 
		{
			if (strExtension == arrExtensions[i]) 
			{
				blnExists = true;
				break;
			}
		}
		
		if (!blnExists)
			alert("Only upload file with CSV extension","File Upload Failed");
		return blnExists;
		
		if (formDOMObj.attach1.value == "" && formDOMObj.attach2.value == "" && formDOMObj.attach3.value == "" && formDOMObj.attach4.value == "" )
			alert("Please press the Browse button and pick a file.")
		else
			return true;
		return false;
	}

	</script>


</head>

<style type="text/css">

	#txtHint
	{
		width:auto;
		height:80%;
		z-index:0;
		font-size:90%;
		
	}

	#txtTerbilang
	{
		width:auto;
		padding-left:15%;
		font-size:150%;
		text-align:left;
		color:#F00;
	}

	textarea {
		res0ize: none;
		width: 20%;
	}

	#txtcustomer
	{
		overflow:auto;
		overflow-x:hidden;
	}

	#listcust:hover
	{
		background-color:#FFFD00;
	}
</style>
<body>
<div class="wrap-70">
	<div class="row">
		<header class="kepala">
			<div class="kep-jud"><h1>UPLOAD CSV INSENTIF</h1></div>
		</header>
	</div>
	<hr />


	<form name="frmSend" method="POST" enctype="multipart/form-data" action="index.asp" onSubmit="return onSubmitForm(this);">   	

	<fieldset style="text-align: center;">
	<legend>UPLOAD CSV</legend>
		<div class="row col-12">
			<label>Pilih File CSV untuk customerID: </label>
			<div class="row space">
				<input type="file" name="filter" id="filter" accept=".csv" class="tombol tombolblack full_12">
		   
			</div>
		</div>
	</fieldset>
	<div class="row col-12">
		<input type="submit" value="UPLOAD" class="tombol tombolorens full_12">
		<input type="button" value="KEMBALI" class="tombol tombolorens full_12" onclick="window.location.href='../dashboard.asp'">
	</div>
	</form>

<%
Dim diagnostics
if Request.ServerVariables("REQUEST_METHOD") <> "POST" then
    diagnostics = TestEnvironment()
    if diagnostics<>"" then
        response.write "<div style=""margin-left:20; margin-top:30; margin-right:30; margin-bottom:30;"">"
        response.write diagnostics
        response.write "<p>Please contact IT to correct this problem, reload the page."
        response.write "</div>"
    else
        response.write "<div style=""margin-left:150"">"
        OutputForm()
        response.write "</div>"
    end if
else
    response.write "<div style=""margin-left:150"">"
    OutputForm()
    response.write SaveFiles()
    response.write "<br><br></div>"
end if

%>

</body>
</html>