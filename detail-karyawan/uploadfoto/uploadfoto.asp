<%@ Language=VBScript %>
<% 
option explicit 
Response.Expires = -1
Server.ScriptTimeout = 600



%>
<!-- #include file="uploadfile.asp" -->
<%


' ****************************************************
' Change the value of the variable below to the pathname
' of a directory with write permissions, for example "C:\Inetpub\wwwroot"
  Dim uploadsDirVar
 dim area
area = request("area")
	if area = "" then
		response.AddHeader "REFRESH","0:URL=uploadFoto.asp?nip=000000000"
	end if

  uploadsDirVar = "D:\newsite\hrd\Foto\"
  
' ****************************************************


function OutputForm()
%>


<%
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
    Dim Upload, fileName, fileSize, ks, i, fileKey

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
        next
    else
        SaveFiles = "The file name specified in the upload form does not correspond to a valid file in the system."
    end if
	
end function
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=`, initial-scale=1.0">
    <TITLE>UPLOAD FHOTO KARYAWAN</TITLE>
    <!-- #include file='../../layout/header.asp' -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <!-- link header -->


<script>
function onSubmitForm(objForm) {
    var formDOMObj = document.frmSend;
    var arrExtensions=new Array("jpg");
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
		alert("Only upload Photo with JPG extension only","File Upload Failed");
	return blnExists;
	
    if (formDOMObj.attach1.value == "" && formDOMObj.attach2.value == "" && formDOMObj.attach3.value == "" && formDOMObj.attach4.value == "" )
        alert("Please press the Browse button and pick a file.")
    else
        return true;
    return false;
}


</script>

<link rel="stylesheet" type="text/css" href="css/style.css">
<style>
    .container{
        margin-top:20px;
        background-color:whitesmoke;
        border:2px solid black;
        border-radius:20px;
    }
    .upload{
        margin-left:30%;
    }
    .upload button[type=button]{
        margin-left:-34px;
    }
    .upload img{
        max-width:15%;
        margin-top:-8%;
         float: right;
    }
</style>

</HEAD>

<BODY>
<div class="container">
    <div class="upload">
        <form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadFoto.asp" onSubmit="return onSubmitForm(this);">   	<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
        
        <p style="margin-top: 0; margin-bottom: 0"><b>File To Upload : </b>
        <input name="filter" type="file" size="20" />
        <button type="submit" class="btn btn-primary" value="UPLOAD">UPLOAD</button>
        </p>
        </form> 
        <%
        Dim diagnostics
        if Request.ServerVariables("REQUEST_METHOD") <> "POST" then
            diagnostics = TestEnvironment()
            if diagnostics<>"" then
                response.write "<div style=""margin-left:20; margin-top:30; margin-right:30; margin-bottom:30;"">"
                response.write diagnostics
                response.write "<p>After you correct this problem, reload the page."
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
        <u><b>Ketentuan :</b></u><ul>
        <li>Pastikan nama file Photo sudah sesuai dengan NIP karyawan yang bersangkutan.</li>
        <li>CONTOH : 001080203.jpg</li>
        <li>Kami hanya menerima foto dalam bentuk format file *.jpg</li>

        <button type="button" onclick="window.location.href='tambah.asp'" class="btn btn-danger mt-4">Kembali</button>
        <img src="Foto/Dakota_1.PNG">
    </div>
</div>
<!-- #include file='../../layout/footer.asp' -->
