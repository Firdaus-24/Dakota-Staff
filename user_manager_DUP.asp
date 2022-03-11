<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="Connections/cargo.asp" -->
<html>

<head>

<%
uname = request.QueryString("uname")
rname = request.QueryString("rname") 
cabang = request.QueryString("cabang")
kd = request.QueryString("kd")
pt = request.QueryString("pt")
%>

<!-- javascript enter sebagai tab -->
<script type='text/javascript' src="js/enterToTab.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    $("input").not( $(":button") ).keypress(function (evt) {
      if (evt.keyCode == 13) {
        iname = $(this).val();
        if (iname !== 'Submit'){  
          var fields = $(this).parents('form:eq(0),body').find('button,input,textarea,select');
          var index = fields.index( this );
          if ( index > -1 && ( index + 1 ) < fields.length ) {
            fields.eq( index + 1 ).focus();
          }
          return false;
        }
      }
    });
    });

</script>

<% 
if session("username") = "" and session("cabang") = "" then
Session.Contents.RemoveAll()
response.Redirect("login.asp")
end if
%>

<%

dim agen
dim agen_cmd

set agen_cmd = server.CreateObject("ADODB.Command")
agen_cmd.activeConnection = MM_Cargo_string

agen_cmd.commandtext = "SELECT     agen_nama FROM         GLB_M_Agen WHERE     (Agen_AktifYN = 'Y') ORDER BY Agen_Nama" 
agen_cmd.prepared = true
set agen = agen_cmd.execute

dim perwakilan
dim perwakilan_cmd

set perwakilan_cmd = server.CreateObject("ADODB.Command")
perwakilan_cmd.activeConnection = MM_Cargo_string

perwakilan_cmd.commandText = "SELECT     Perwakilan_Nama FROM         GLB_M_Perwakilan WHERE     (Perwakilan_AktifYN = 'Y') ORDER BY Perwakilan_Nama"
perwakilan_cmd.prepared = true

set perwakilan = perwakilan_cmd.execute

%>


<style type="text/css">
.box {

padding: 5px;
margin: 5px;
width: 90%;
height: 70%;
}


fieldset {
  background-color:#CCC;	
  padding: 1em;
  font:80%/1 sans-serif;
  border:1px solid green;
  }


label {
  float:left;
  width:25%;
  margin-right:0.5em;
  padding-top:0.2em;
  text-align:right;
  font-weight:bold;
  }


legend {
	background-color:#FFF;
  padding: 0.2em 0.5em;
  border:1px solid green;
  color:green;
  font-size:90%;
  text-align:right;
  }  
  
  button
  {

	  width:110px;
	  height:25px;
	  background-color:#000;
	  float:right;
	  text-align:center;
	  color:#FF0;
	
  }
  button:hover
  {
	  background-color:#F00;
	  
  }
	input:focus
	{
		background-color:#FF0;
	}

#txtHint
{

	padding:10px;
	border-radius:1px;
	box-shadow:15px 15px 15px 1px;
	position:absolute;
	top:10%;
	left:50%;
	color:#000;
	background-color:#CCC;
	font-size:110%;
	z-index:0;
	
}

#txtTerbilang
{
	width:auto;
	padding-left:15%;
	font-size:150%;
	text-align:left;
	color:#F00;
}

</style>


<title>Username Active : <% =(Session.Contents(1)) %>| Server : <%=session("cabang") %> | Login Time : <%=now() %></title>

<script>

function uppercase()
{
	document.formInput.username.value = document.formInput.username.value.toUpperCase();
	document.formInput.alamat.value = document.formInput.alamat.value.toUpperCase();
	document.formInput.contactPerson.value = document.formInput.contactPerson.value.toUpperCase();
	
}


</script>


<script type="text/javascript">
function passwordCompare()
{
	if(document.getElementById("password1").value != document.getElementById("password2").value)
	{
		document.getElementById("txtHint").innerHTML = "Password Awal dan Password Konfirmasi harus sama";
		document.getElementById("simpan").disabled=true;

	}
	else
	{
				document.getElementById("txtHint").innerHTML = "";
		document.getElementById("simpan").disabled=false;
	}
}


</script>


<script type="text/javascript">
function namaPengguna()
{
	if(document.getElementById("namaPengguna").value = "")
	{
		document.getElementById("txtHint").innerHTML="Nama Pengguna harus di isi, pastikan tidak sama dengan username / nama yang sudah ada";
		document.getElementById("simpan").disabled=true;
	}
	else
	{
			document.getElementById("txtHint").innerHTML="";
		document.getElementById("simpan").disabled=false;
	}
}

</script>

</head>

<% server.Execute("footer.asp") %>


<body>
<div class="box">
<form name="formInput" action="p-user_manager_DUP.asp" method="post">
		<!-- ============================== Fieldset 1 ============================== -->
  <fieldset>
	<legend>Pendaftaran Pengguna Aplikasi Web Dakota Cargo:</legend>
 <label>Nama Pengguna [ Username ]</label>
<input name="username" type="text" size="30" onKeyDown="uppercase();" onKeyUp="uppercase();" onKeyPress="uppercase();" onBlur="namaPengguna();" id="namaPengguna" value="<%=uname%>">
<input name="vuname" type="text" value="<%=uname%>" readonly hidden="">
<br>

 <label>Nama ASLI PENGGUNA [ Surename ]</label>
<input name="surename" type="text" size="30" onKeyDown="uppercase();" onKeyUp="uppercase();" onKeyPress="uppercase();" onBlur="uppercase();" value="<%=rname%>"><br>

<label>Kata Sandi [ Password ]</label>
<input name="password1" type="text" maxlength="100" size="100" value="123456" id="password1"><br>

<label>Kata Sandi Konfirmasi [ Ulangi Password ]</label>
<input name="password2" type="text" maxlength="100" size="100" value="123456" id="password2" onBlur="passwordCompare()"><br>

<div id="txtHint"></div>

<label>Cabang / Agen / Perwakilan</label>
<select name="agen"> 
		<option value="<%=cabang%>"><%=cabang%></option>
 		   <% while not agen.eof %>
    	<option value="<%=(agen.Fields.Item("agen_nama").Value)%>"><%=(agen.Fields.Item("agen_nama").Value)%></option>
    
    <% agen.movenext 
		wend
	%>
    
     <% while not perwakilan.eof %>
    	<option value="<%=(perwakilan.Fields.Item("perwakilan_nama").Value)%>"><%=(perwakilan.Fields.Item("perwakilan_nama").Value)%></option>
    
    <% perwakilan.movenext 
		wend
	%>
</select>
<input name="vagen" type="text" value="<%=cabang%>" readonly hidden="">       
<input name="vkd" type="text" value="<%=kd%>" readonly hidden="">   
<input name="vpt" type="text" value="<%=pt%>" readonly hidden="">  
        
<br>
  


   </fieldset>
   <button tabindex="14" class="tombolinput" type="reset" value="RESET">RESET</button> <button tabindex="15" class="tombolinput" type="button" value="BATAL" onClick="window.open('user_manager.asp','_self');">BATAL</button> <button tabindex="13" class="tombolinput" type="submit" value="SIMPAN" id="simpan" >SIMPAN</button>	


</div>      


	</form>
		
 </div>     

    




</body>
</html>