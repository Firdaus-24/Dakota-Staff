<!-- #include file='../connection.asp' -->
<%
p = Request.QueryString("p")
e = Request.QueryString("e")
nip = Request.QueryString("nip")

set cek_cmd = server.CreateObject("ADODB.Command")
cek_cmd.activeConnection = MM_Cargo_string

cek_cmd.commandtext="SELECT Agen_ID, Agen_Nama FROM GLB_M_Agen WHERE (Agen_AktifYN = 'Y') AND (Agen_Nama NOT LIKE '%xxx%') ORDER BY Agen_Nama"
set cbg=cek_cmd.execute
%>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACTIVE AGEN</title>
    <!-- #include file='../layout/header.asp' -->
    <script src="<%= url %>/js/jquery-3.5.1.min.js"></script> 

    <!-- javascript enter sebagai tab -->
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

    <!-- ubah input ke huruf besar / kapital -->
    <script>
    function kapital(obj) 
        {
            obj.value=obj.value.toUpperCase();
        }
    </script>
</head>
<body>
    <div class='container'>
        <div class='row text-center mt-3 mb-3'>
            <div class='col'>
                <h3>FORM RUBAH ACTIVE AGEN KARYAWAN</h3>
                <p style="margin-top:-10px;color:red;">form ini hanya merubah aktif agen karyawan yang di pindah tugaskan sementara</p>
            </div>
        </div>
        <% if e <> "" then %>
        <div class='row'>
            <div class='col'>
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <strong>PERINGATAN</strong> Nip karyawan tidak terdaftar
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <% end if %>
        <% if p <> "" then %>
        <div class='row'>
            <div class='col'>
                <div class="alert alert-primary alert-dismissible fade show" role="alert">
                    <strong>YES...</strong> Karyawan berhasil diubah
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <% end if %>
        <div class='row'>
            <form action="pactiveAgen.asp" method="post">
            <div class='col'>
                <div class="mb-3 row">
                    <label for="nip" class="col-sm-2 col-form-label">Nip</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="nip" name="nip" value="<%= nip %>" readonly >
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="area" class="col-sm-2 col-form-label">Area</label>
                    <div class="col-sm-10">
                        <select class="form-select" aria-label="Default select example" id="area" name="area" required>
                            <option value="">Pilih</option>
                            <%	do while not cbg.eof	%> 
                                    <option value="<%=cbg("Agen_ID")%>"><%=cbg("Agen_Nama") &" | "& right("000"&cbg("Agen_ID"),3)%></option>
                            <%	cbg.movenext
                                loop	%>
                        </select>
                    </div>
                </div>
            </div>
            <button type="button" class="btn btn-danger" onclick="window.location.href='<%= url %>/index.asp'">Kembali</button>
            <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </div>
<!-- #include file='../layout/footer.asp' -->