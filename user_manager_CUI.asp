<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="Connections/cargo.asp" -->
<html>

<head>
<% server.Execute("header.asp") %>
<%
uname = request.QueryString("uname")
rname = request.QueryString("rname") 
cabang = request.QueryString("cabang")
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
#txthint{
		text-align: center;
		color: red;
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
		document.getElementById("txtHint").innerHTML = "<blink>Password Awal dan Password Konfirmasi harus sama</blink>";
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
<div class="wrap-50">
		<div class="row col-12">
			<header class="kepala">
				<div class="kep-jud"> <h1>Pendaftaran Pengguna Aplikasi Dakota Cargo</h1> </div>
			</header>
		</div>

	<form name="formInput" action="p-user_manager_CUI.asp" method="post">
				<!-- ============================== Fieldset 1 ============================== -->
		  <fieldset>
			<legend>Pendaftaran Pengguna Aplikasi Web Dakota Cargo</legend>
				<div class="row">
					<div class="col-12">
						<div class="col-6">
							<label>Nama Pengguna [ Username ]</label>
							<input name="username" type="text" maxlength="10" size="30" onKeyDown="uppercase();" onKeyUp="uppercase();" onKeyPress="uppercase();" onBlur="namaPengguna();" id="namaPengguna" value="<%=uname%>" readonly>
						</div>
						<div class="col-6">
						
							<label>Nama ASLI PENGGUNA [ Surename ]</label>
							<input name="surename" type="text" maxlength="10" size="30" onKeyDown="uppercase();" onKeyUp="uppercase();" onKeyPress="uppercase();" onBlur="uppercase();" value="<%=rname%>" required />
						</div>
					</div>
					
					<div class="col-12">
						<div class="col-6">
							<label>Kata Sandi [ Password ]</label>
							<input name="password1" type="text" maxlength="100" size="100" value="123456" id="password1" required />
						</div>
					</div>
							
					<div class="col-12">
						<div class="col-6">
							<label>Kata Sandi Konfirmasi [ Ulangi Password ]</label>
							<input name="password2" type="text" maxlength="100" size="100" value="123456" id="password2" onBlur="passwordCompare()" required />

						</div>
					</div>
					<div class="col-12">
						<div class="col-3">
							<label>Cabang / Agen / Perwakilan</label>
							<select name="agen" required /> 
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
								</select><br>
				  
						</div>
					</div>


		   </fieldset>
		  
		  <div id="txtHint"></div>
		  	<div class="col-12">
				<button tabindex="13" class="tombol tombolorens full_12" type="submit" value="SIMPAN" id="simpan" >SIMPAN</button>	
				<button tabindex="15" class="tombol tombolred full_12 float-r" type="button" value="BATAL" onClick="window.open('user_manager.asp','_self');">BATAL</button> 
				<button tabindex="14" class="tombol full_12 float-r" type="reset" value="RESET">RESET</button> 
			
			   
			</div>
		


		   


	</form>
		
 </div>     

    
	
	  <% server.Execute("futer.asp") %>




</body>
</html>