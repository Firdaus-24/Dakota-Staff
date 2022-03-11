<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("login.asp")
end if
%>
<% 
		server.Execute("style_header.asp")
	%>
<!--#include file="Connections/cargo.asp" -->
<!--#include file="secureString.asp" -->


<!-- Javascript Tanggal kalender Date Picker -->
<script type="text/javascript" src="js/tcal.js"></script>

<!-- CSS Tanggal Date kalender Picker -->
<link rel="stylesheet" type="text/css" href="css/tcal.css" />




<script>
function fokus()
{
document.getElementById('nama').focus();
}
</script>


<!-- Trap Enter sebagai TAB -->
<script>
function tab(field, event) {
    if (event.which == 13 /* IE9/Firefox/Chrome/Opera/Safari */ || event.keyCode == 13 /* IE8 and earlier */ ) {
        for (i = 0; i < field.form.elements.length; i++) {
            if (field.form.elements[i].tabIndex == field.tabIndex + 1) {
                field.form.elements[i].focus();
                if (field.form.elements[i].type == "text") {
                    field.form.elements[i].select();
                    break;
                }
            }
        }
        return false;
    }
    return true;
}
</script>

<!-- ubah input ke huruf besar / kapital -->
<script>
function kapital(obj) 
{
  obj.value=obj.value.toUpperCase();
}

</script>


<style>
	th{
		font-size: 10px;
	}
	.tombol{
		margin: 0;
	}
	#demo{
		padding-top: 50px;
	}
</style>

<style>
/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 100%;
    height: 50%;
}

/* The Close Button */
.close {
    color: #f10000;
    float: right;
    font-size: 28px;
    font-weight: bold;
	padding: 5px;
    background-color: salmon;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}
</style>

<body onLoad="fokus();eSPNumber();">

<div class="wrap-50">
	<div class="row col-12">
		<header class="kepala">
			<div class="kep-jud"> <h1>Tambah Device Karyawan Dari Link Whatsapp</h1> </div>
		</header>
	</div>
	<hr />
	<form action="p-hrd_m_kry_device_a.asp" method="post" id="formSP" name="formSP">
		<div class="row">	
			<div class="row col-12">
				<div class="col-12">
					<label>Link :</label>
					<input name="nama" id="nama" type="text"  maxlength="" size="7"  placeholder="Masukkan Link Dari Whatsapp" /> 
				</div>
			</div>
		</div>

		<hr>
		<input type="submit" value="SIMPAN" class="tombol tombolgrey full_12"  />
		<input type="button" value="KELUAR" onClick="window.open('hrd_m_kry_device.asp','_self')" class="tombol tombolred full_12 float-r" style="float: right;">
			
		
		
	</form>
</div>
	<% 
	server.Execute("futer.asp")
	%>	
</body>
