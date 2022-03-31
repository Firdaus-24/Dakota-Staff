<!-- #include file="../../connection.asp"-->
<!--#include file="../../landing.asp"-->
<!-- #include file='../../constend/constanta.asp' -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Karyawan</title>
    <!--#include file="../../layout/header.asp"-->
</head>
<body>
<% 

    Set karyawan_cmd = Server.CreateObject ("ADODB.Command")
    karyawan_cmd.ActiveConnection = MM_cargo_STRING

    set nip = Request.QueryString("nip")

    karyawan_cmd.commandText ="SELECT * from HRD_M_Karyawan where Kry_Nip = '" & nip & "' "
    set karyawan = karyawan_cmd.execute

    ' cek atasan
    if karyawan.eof then
        atasan1 = ""
        atasan2 = ""
    else
        atasan1 = karyawan("Kry_atasanNip1")
        atasan2 = karyawan("Kry_atasanNip2")
    end if

    ' koneksi ke divisi
    set divisi_cmd = Server.CreateObject("ADODB.Command")
    divisi_cmd.ActiveConnection = MM_cargo_STRING


    ' koneksi area
    set area_cmd = Server.CreateObject("ADODB.Command")
    area_cmd.ActiveConnection = MM_cargo_STRING

    ' koneksi ke db jabatan
    set jabatan_cmd = Server.CreateObject("ADODB.Command")
    jabatan_cmd.ActiveConnection = MM_cargo_STRING

    ' koneksi grup shift
    set gs_cmd = Server.CreateObject("ADODB.Command")
    gs_cmd.ActiveConnection = MM_cargo_STRING

    'jenjang
    set jenjang_cmd = Server.CreateObject("ADODB.Command")
    jenjang_cmd.ActiveConnection = MM_cargo_STRING

    set SETjenjang_cmd = Server.CreateObject("ADODB.Command")
    SETjenjang_cmd.ActiveConnection = MM_cargo_STRING

    'agama
    set agama_cmd = Server.CreateObject("ADODB.Command")
    agama_cmd.ActiveConnection = MM_cargo_STRING

    'pendidikan
    Set pendidikan_cmd = Server.CreateObject ("ADODB.Command")
    pendidikan_cmd.ActiveConnection = MM_cargo_STRING

 %>
<!--judul-->
<section class="content-detail" name="content-detail" id="content-detail">
		<h3 class="text-center mt-3 mb-3">UPDATE DATA KARYAWAN</h3>
    <div class="container mt-2 mb-3 px-4 bg-light data-detail" style="border-radius:5px;">
        <div class="row gx-5">
		<!-- start form -->
		<form action="update_add.asp?nip=<%= karyawan("Kry_NIP") %> " method="post" name="formKaryawan" onsubmit="return validasiubahkaryawan()">
            <div class="col-2 image top-50">    
                <img  id="image" style="width:150px;" src="../../Foto/<%= trim(karyawan("Kry_NIP")) %>.JPG " onerror="this.onerror=null;this.src='../../Foto/NoPhotoAvailable.JPG';"> 
            </div>
            <div class="col">
                <div class="row">
                    <div class="col-sm-6">
                        <label>NIP</label>
                            <input type="text" class="form-control" name="nip" id="nip" value="<%= karyawan("Kry_NIP") %>"readonly>
                        <label>Nama</label>
                            <input type="text" name="nama" class="form-control" id="nama" value="<%= karyawan("Kry_Nama") %>">
                        <label>Alamat</label>
                            <input type="text" name="alamat"  class="form-control" id="alamat" value="<%= karyawan("Kry_Addr1") %>">
                        <label>Kelurahan</label>
                            <input type="text" name="kelurahan"  class="form-control" id="kelurahan" value="<%= karyawan("Kry_Addr2") %>">
                    </div>
                    <div class="col-sm-6">
                        <div class="form-check form-check-inline">
                        <label class="mt-2 mb-1 d-flex flex-row">BPJS KES</label>
                            <div class="form-check form-check-inline">
                                <% if karyawan("Kry_BPJSKesYN") = "Y" then%> 
                                    <input class="form-check-input" type="radio" name="bpjskes" id="bpjskesY" value="Y" checked>
                                <% else %> 
                                    <input class="form-check-input" type="radio" name="bpjskes" id="bpjskesY" value="Y">
                                <% end if %> 
                                    <label class="form-check-label" for="bpjskesY">Yes</label>
                                </div>
                                <div class="form-check form-check-inline">
                                <% if karyawan("Kry_BPJSKesYN") = "N" then%> 
                                    <input class="form-check-input" type="radio" name="bpjskes" id="bpjskesN" value="N" checked>
                                <% else %> 
                                    <input class="form-check-input" type="radio" name="bpjskes" id="bpjskesN" value="N">
                                <% end if %> 
                                    <label class="form-check-label" for="bpjskesN">No</label>
                            </div>
                        </div>
                        <div class="form-check form-check-inline">
                        <label class="mt-2 mb-1 d-flex flex-row">BPJS KET</label>
                            <div class="form-check form-check-inline">
                                <% if karyawan("Kry_BPJSYN") = "Y" then%> 
                                    <input class="form-check-input" type="radio" name="bpjs" id="bpjs" value="Y" checked>
                                <% else %> 
                                    <input class="form-check-input" type="radio" name="bpjs" id="bpjs" value="Y">
                                <% end if %> 
                                    <label class="form-check-label" for="bpjs">Yes</label>
                                </div>
                                <div class="form-check form-check-inline">
                                <% if karyawan("Kry_BPJSYN") = "N" then%> 
                                    <input class="form-check-input" type="radio" name="bpjs" id="bpjs" value="N" checked>
                                <% else %> 
                                    <input class="form-check-input" type="radio" name="bpjs" id="bpjs" value="N">
                                <% end if %> 
                                    <label class="form-check-label" for="bpjs">No</label>
                            </div>
                        </div>
                        <br>
                        <label>Telphone 1</label>
                            <input type="text" class="form-control" name="tlp1" id="tlp1" value="<%= karyawan("Kry_Telp1") %>">
                        <label>Telphone 2</label>
                            <input type="text" class="form-control" name="tlp2" id="tlp2" value="<%= karyawan("Kry_Telp2") %>">
                        <div class="row">
                            <div class="col-6">
                                <label>Kota</label>
                                    <input type="text" name="kota" class="form-control" id="kota" value="<%= karyawan("Kry_Kota") %>">
                            </div>
                            <div class="col-6">
                                <label>Pos</label>
                                    <input type="text" class="form-control" name="pos" id="pos" value="<%= karyawan("Kry_KdPos") %>">
                            </div>
                        </div>
                    </div>
                </div>
            </div>        
        </div> 
        <div class="row">
            <div class="col-md-6">
                <div class="row">
                    <div class="col-md-8">
                        <label>Tempat Lahir</label>
                            <input type="text" name="tmpt" class="form-control" id="tmpt" value="<%= karyawan("Kry_TmpLahir") %>">
                    </div>
                    <div class="col-md-4">
                        <label>Tanggal Lahir</label>
                            <input type="text" name="tglL" class="form-control" id="tglL" value="<%= karyawan("Kry_TglLahir") %>" onfocus="return ChangeDate()">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-8">
                        <label>Email</label>
                            <input type="email" class="form-control" name="email" id="email" value="<%= karyawan("Kry_Fax") %>">    
                    </div>
                    <div class="col-md-4">
                        <label>Agama</label>
							<select class="form-select" aria-label="Default select example" name="agama" id="agama" >
                            <% 
                                agama_cmd.commandText = "SELECT Agama_Nama, agama_ID FROM GLB_M_Agama"
                                set setagama = agama_cmd.execute
                                
                                agama_cmd.commandText = "SELECT Agama_Nama, agama_ID FROM GLB_M_Agama WHERE Agama_ID = '" &  karyawan("Kry_AgamaID") & "'"
                                set agama = agama_cmd.execute
                                
                                if agama.eof = false then
                                    idagama = agama("agama_ID")
                                    nameagama = agama("agama_Nama")
								%>
									<option value="<%=agama("agama_ID")%>"><%=agama("agama_Nama")%></option>
								<%
                                end if
                            %> 
                            
                                
                                <% 
                                do until setagama.eof 
                                %>
                                <option value="<%=setagama("agama_ID")%>"><%=setagama("agama_Nama")%></option>
                                <% 
                                setagama.movenext
                                loop
                                %>
                            </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-8">
                        <label>Jenis Kelamin</label>
                            <select class="form-select" aria-label="Default select example" name="jkelamin" id="jkelammin" >
                                <% if ucase(karyawan("Kry_sex")) = "P" then  %> 
                                    <option value="P">Laki-Laki</option>
                                <% else %>
                                    <option value="W">Perempuan</option>
                                <% end if %>
                                <option value="P">Laki-Laki</option>
                                <option value="W">Perempuan</option>
                            </select>
                    </div>
                    <div class="col-md-4">
                        <label>Status Sosial</label>
                            <select class="form-select" aria-label="Default select example" name="ssosial" id="ssosial" value="<%= karyawan("Kry_SttSosial") %> ">
                                <option value="<%=karyawan("Kry_SttSosial")%>">
                                <%
                                if karyawan("Kry_SttSosial") = 0 then 
                                    Response.Write "Belum Menikah"
                                elseIf karyawan("Kry_SttSosial") = 1 then
                                    Response.Write "Menikah"
                                else 
                                    Response.Write "Janda/Duda"
                                end if
                                 %> </option>
                                <option value="0">Belum Menikah</option>
                                <option value="1">Menikah</option>
                                <option value="2">Janda / Duda</option>
                            </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label>Jumlah Anak</label>
                        <input type="text" name="janak" class="form-control" id="janak" value="<%= karyawan("Kry_JmlAnak") %>">
                    </div>
                    <div class="col-md-6">
                        <label>Tanggungan</label>
                        <input type="text" name="tanggungan" class="form-control" id="tanggungan" value="<%= karyawan("Kry_JmlTanggungan") %>">
                    </div>
                </div>

                <% 
                pendidikan_cmd.commandText = "SELECT JDdk_Nama, JDdk_ID FROM HRD_M_JenjangDidik where JDdk_ID = '"& karyawan("Kry_JDdkID") &"'"
				'response.write pendidikan_cmd.commandText & "<BR>"
                set pendidikan = pendidikan_cmd.execute

                if not pendidikan.eof then
                    idpddk = pendidikan("JDdk_ID")
                    namepddk = pendidikan("JDdk_Nama")
                else
                    idpddk = ""
                    namepddk = ""
                end if
                %> 
                <div class="row">
                    <div class="col-md-6">
                        <label>Pendidikan</label>
                        <select class="form-select" aria-label="Default select example" name="pendidikan" id="pendidikan">
                                <option value="<%= idpddk %>"><%= namepddk %></option>
								<% 
                                pendidikan_cmd.commandText = "SELECT JDdk_Nama, JDdk_ID FROM HRD_M_JenjangDidik"
                                set pendidikan = pendidikan_cmd.execute
                                %>
                                <% do until pendidikan.eof %> 
                                    <option value="<%= pendidikan("JDdk_ID") %>"><%= pendidikan("JDdk_Nama") %> </option>
                                <% 
                                pendidikan.movenext
                                loop %> 
                            </select>
                    </div>
                    <div class="col-md-6">
                        <label>Status Pegawai</label>
                        <select class="form-select" aria-label="Default select example" name="spegawai" id="spegawai" value="<%= karyawan("Kry_SttKerja") %>">
                            <option value="<%= karyawan("Kry_SttKerja") %>">
                            <% 
                            if karyawan("Kry_SttKerja") = 0 then
                                Response.Write "Tetap"
                            elseIf  karyawan("Kry_SttKerja") = 1 then
                                Response.Write "Harian"
                            elseIf karyawan("Kry_SttKerja") = 2 then
                                Response.Write "Kontrak"
                            elseIf karyawan("Kry_SttKerja") = 3 then 
                                Response.Write "Magang"
                            elseIf karyawan("Kry_SttKerja") = 4 then 
                                Response.Write "Borongan"
                            else
                                Response.Write "" 
                            end if
                            %>
                            </option>
                            <option value="0">Tetap</option>
                            <option value="1">Harian</option>
                            <option value="2">Kontrak</option>
                            <option value="3">Magang</option>
                            <option value="4">Borongan</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label>Saudara</label>
                            <input type="number" name="saudara" class="form-control" id="saudara" value="<%= karyawan("Kry_JmlSaudara") %>">
                    </div>
                    <div class="col-md-6">
                        <label>Anak Ke-</label>
                            <input type="number" name="anakke" class="form-control" id="anakke" value="<%= karyawan("Kry_AnakKe") %>">
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <label>Bank Id</label>
                            <select class="form-select" aria-label="Default select example" value="<%= karyawan("Kry_BankID") %> " name="bankID" id="bankID">
                                <option value="<%= karyawan("Kry_BankID") %>">
                                <%
                                    if karyawan("Kry_BankID") = 0 then
                                        Response.Write "Bank Central Asia (PST)"
                                    elseIf karyawan("Kry_BankID") = 1 then
                                        Response.Write "Mandiri"
                                    else
                                        Response.Write "BCA"
                                    end if
                                
                                %>
                                </option>
                                <option value="0">Bank Central Asia (PST)</option>
                                <option value="1">Mandiri</option>
                                <option value="2">BCA</option>
                            </select>
                    </div>
                    <div class="col">
                        <label>No Rekening</label>
                            <input type="text" name="norek" class="form-control" id="norek" value="<%= karyawan("Kry_NoRekening") %>">
                    </div>
                </div>
                <div class='row'>
                    <div class="col">
                        <label>BPJS Kesehatan</label>
                            <input type="text" name="kesehatan" class="form-control" id="kesehatan" value="<%= karyawan("Kry_NoBPJS") %> ">
                    </div>
                    <div class="col">
                        <label>Ketenagakerjaan</label>
                            <input type="text" name="jamsostek" class="form-control" id="jamsostek" value="<%= karyawan("Kry_NoJamsostek") %>">
                    </div>
                </div>            
            </div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col-6">
                        <label>Atasan 1</label>
                            <input type="text" name="atasan1" class="form-control" id="atasan1" value ="<%= atasan1 %>" maxlength="10" autocomplete="off">
                    </div>
                    <div class="col-6">
                        <label>Atasan 2</label>
                            <input type="text" class="form-control" name="atasan2" id="atasan2" value="<%= atasan2 %>" maxlength="10" autocomplete="off">
                    </div>
                </div>
                <%
                    area_cmd.commandText = "select agen_ID, agen_nama from glb_m_agen where agen_aktifYN = 'Y' and Agen_nama not like '%XXX%' order by agen_nama"
                    set area = area_cmd.execute

                    area_cmd.commandText = "select agen_ID, agen_nama from glb_m_agen WHERE agen_ID = '"& karyawan("Kry_Pegawai")  &"' "
                    set pegawai = area_cmd.execute
                    
                    area_cmd.commandText = "select agen_ID, agen_nama from glb_m_agen WHERE agen_ID = '"& karyawan("Kry_AgenID") &"'"
                    set aktif = area_cmd.execute

                    if not aktif.eof then
                        aktifID = aktif("Agen_Nama")
                    else
                        aktifID = ""
                    end if
                %>
                <label>Pegawai</label>
                    <select class="form-select" aria-label="Default select example" name="pegawai"  id="pegawai">
                        <option value="<%= pegawai("agen_ID") %>"><%= pegawai("agen_nama") %></option>
                        <% do until area.EOF %> 
                            <option value="<%= area("agen_ID") %> "><%= area("agen_nama") %> </option>
                        <% 
                        area.movenext 
                        loop
                        area.movefirst  

                        %> 
                    </select>
                <label>Sub Cabang</label>
                <select class="form-select" aria-label="Default select example" name="ActiveId"  id="ActiveId">
                    <option value="<%= karyawan("Kry_ActiveAgenID") %>"><%= aktifID %></option>
                    <% 
                    do until area.EOF
                    %> 
                        <option value="<%= area("agen_ID") %> "><%= area("agen_nama") %> </option>
                    <% area.movenext 
                    loop%> 
                </select>
                <% 

                    jabatan_cmd.commandText = "SELECT Jab_Code, Jab_Nama FROM HRD_M_Jabatan WHERE Jab_AktifYN = 'Y' ORDER BY Jab_Nama ASC"
                    set setjabatan = jabatan_cmd.execute

                    jabatan_cmd.commandText = "SELECT Jab_Code, Jab_Nama FROM HRD_M_Jabatan WHERE Jab_Code = '"& karyawan("Kry_JabCode") &"'"
                    set jabatan = jabatan_cmd.execute

                    if not jabatan.eof then
                        idjab = jabatan("Jab_COde")
                        namejab = jabatan("Jab_Nama")
                    else
                        idjab = ""
                        namejab = ""
                    end if
                 %>  
                 <label>Jabatan</label>
                    <select class="form-select" aria-label="Default select example" name="jabatan"  id="jabatan">
                        <option value="<%= idjab %>"><%= namejab %></option>
                        <% 
                        do until setjabatan.EOF
                        %> 
                            <option value="<%= setjabatan("Jab_Code") %> "><%= setjabatan("Jab_Nama") %> </option>
                        <% setjabatan.movenext 
                        loop%> 
                    </select>
                <label>Jenjang</label>
					<select class="form-select" aria-label="Default select example" name="jenjang" id="Jenjang">
					<% 
                        if len(karyawan("Kry_JJID")) >= 1 then
						jenjang_cmd.commandText = "SELECT JJ_ID, JJ_Nama FROM HRD_M_Jenjang WHERE JJ_ID = "& karyawan("Kry_JJID") &""
						response.write jenjang_cmd.commandText & "<BR>"
                        set jenjang = jenjang_cmd.execute

                        if jenjang.eof = false then
                    %> 
						<option  value="<%= jenjang("JJ_ID") %>"><%= jenjang("JJ_Nama") %></option>
					<% end if 
						end if
					%>
						
						<% 
						SETjenjang_cmd.commandText = "SELECT JJ_ID, JJ_Nama FROM HRD_M_Jenjang WHERE JJ_AktifYN = 'Y' ORDER BY JJ_Nama ASC"
						'response.write SETjenjang_cmd.commandText & "<BR>"
                        set setjenjang = SETjenjang_cmd.execute
						
						do while not setjenjang.EOF %> 
                            <option value="<%= setjenjang("JJ_ID") %> "><%= setjenjang("JJ_Nama") %> </option>
                        <% setjenjang.movenext 
                        loop%> 
                    </select>
                <label>Divisi</label>
                    <% 
                        divisi_cmd.commandText = "select Div_Code, Div_Nama from HRD_M_Divisi WHERE Div_AktifYN = 'Y' ORDER BY Div_Nama ASC"
                        set divisi = divisi_cmd.execute
                        
                        divisi_cmd.commandText = "select Div_Code, Div_Nama from HRD_M_Divisi WHERE Div_Code = '"& karyawan("Kry_DDBID") &"'"

                        set setdivisi = divisi_cmd.execute

                        if not setdivisi.eof then
                            iddiv = setdivisi("Div_Code")
                            namediv = setdivisi("Div_Nama")
                        else    
                            iddiv = ""
                            namediv = ""
                        end if
                    %> 
                    <select class="form-select" aria-label="Default select example" name="divisi" id="divisi">
                            <option value="<%=iddiv%>"><%=namediv%></option>
                        <% do until divisi.EOF %> 
                        <option value="<%= divisi("Div_Code") %> "><%= divisi("Div_Nama") %> </option>
                        <% divisi.movenext 
                        loop%> 
                    </select>
                <div class="row">
                    <div class="col">
                        <label>Jumlah Cuti</label>
                            <input type="text" name="jcuti" class="form-control" id="jcuti" value="<%= karyawan("Kry_JmlCuti") %>">
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <label>No KTP</label>
                            <input type="number" name="nKTP" class="form-control" id="nKTP" value="<%= karyawan("Kry_NoID") %>">
                    </div>
                    <div class="col">
                        <label>NPWP</label>
                            <input type="text" name="npwp" class="form-control" id="npwp" value="<%= karyawan("Kry_NPWP") %>">
                    </div>
                </div>
            </div>
        </div>    
        <div class="row">
            <div class="col-lg-4">
                <div class="row">
                    <div class="col-6">
                        <label>Tanggal Masuk</label>
                            <input type="text" name="tglmasuk" class="form-control" id="tglmasuk" <% if karyawan("Kry_tglMasuk") = "1/1/1900" then %> value="" <% else %> value="<%= karyawan("Kry_TglMasuk") %>" <% end if %> onfocus="return ChangeDateMasuk()">
                    </div>
                    <div class="col-6">
                        <label>Tanggal Keluar</label>
                            <input type="text" name="tglkeluar" class="form-control" id="tglkeluar" <% if karyawan("Kry_tglKeluar") = "1/1/1900" then %> value="" <% else %> value="<%= karyawan("Kry_TglKeluar") %>" <% end if %> onfocus="return ChangeDateKeluar()">
                    </div>
                </div>
                <div class="row">
                    <div class="col-6">
                        <label>Tanggal StartGaji</label>
                            <input type="text" name="tglagaji" id="tglagaji" class="form-control" id="tglagaji" <% if karyawan("Kry_TglStartGaji") = "1/1/1900" then %> value="" <% else %> value="<%= karyawan("Kry_TglStartGaji") %>" <% end if %> onfocus="return ChangeDateAGaji()">
                    </div>
                    <div class="col-6">
                        <label>Tanggal EndGaji</label>
                            <input type="text" name="tglegaji" id="tglegaji" class="form-control" <% if karyawan("Kry_TglEndgaji") = "1/1/1900" then %> value="" <% else %> value="<%= karyawan("Kry_TglEndGaji") %>" <% end if %> onfocus="return ChangeDateEGaji()">
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="row">
                    <div class="col">
                        <label>No SIM</label>
                            <input type="number" name="nsim" class="form-control" id="nsim" value="<%= karyawan("Kry_NoSIM") %>">
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <label>Berlaku SIM</label>
                            <input type="text" name="berlakuSIM" class="form-control" id="berlakuSIM" <% if karyawan("Kry_SimValidDate") = "1/1/1900" then %> value="" <% else %> value="<%= karyawan("Kry_SIMValidDate") %>" <% end if %> onfocus="return ChangeDateSim()">
                    </div>
                    <div class="col">
                        <label>Jenis SIM</label>
                        <select class="form-select" aria-label="Default select example" name="jsim" id="jsim" value="<%=  karyawan("Kry_JnsSIM") %> ">
								<% if karyawan("Kry_JnsSIM") = "0" then%> 
									<option value="0">A</option>
								<% elseIf karyawan("Kry_JnsSIM") = "1" then %> 
									<option value="1">B1</option>
								<% elseIf karyawan("Kry_JnsSIM") = "2" then %> 
									<option value="2">B1 UMUM</option>
								<% elseIf karyawan("Kry_JnsSIM") = "3" then %> 
									<option value="3">A UMUM</option>
								<% elseIf karyawan("Kry_JnsSIM") = "4" then %> 
									<option value="4">B2 UMUM</option>
								<% elseIf karyawan("Kry_JnsSIM") = "5" then %> 
									<option value="5">C</option>
								<% else %>
									<option value="">PILIH</option>
								<% end if %> 
							
                            <option value="0">A</option>
                            <option value="1">B1</option>
							<option value="2">B1 UMUM</option>
                            <option value="3">A UMUM</option>
							<option value="4">B2 UMUM</option>
							<option value="5">C</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="row">
                    <div class="col">
                        <label>Jenis Vaksin</label>
                        <input type="text" name="vaksin" class="form-control" id="vaksin" maxlength="100" <%if not karyawan.eof then%> value="<%= karyawan("Kry_JenisVaksin") %>" <%end if%>>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6">
                        <label>Golongan Darah</label>
                        <select class="form-select" aria-label="Default select example" name="goldarah" id="goldarah">
                            <%if karyawan.eof then %>
                                <option value="">Pilih</option>
                            <%else%>
                                <option value="<%= karyawan("Kry_golDarah") %>"><%=karyawan("Kry_golDarah")%></option>
                            <%end if%>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="AB">AB</option>
                            <option value="O">O</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>  
        <div class="row mt-3 p-2 ">  
            <div class="col-lg-3 mt-3 " >
                <button type="submit" name="submit" id="submit" onclick="return confirm('Yakin untuk diupdate??')"class="btn btn-primary submit">Update</button>
		</form>
		<!-- end form -->
                <button type="button" onclick="window.location.href='../index.asp?nip=<%=nip%>'" class="btn btn-danger kembali">Kembali</button>
            </div>
        </div>
    <div>
</section>
<script>
    function validasitambahkaryawan() {
            // cari data
            var nama = document.forms["formKaryawan"]["nama"].value;
            var alamat = document.forms["formKaryawan"]["alamat"].value;
            var kelurahan = document.forms["formKaryawan"]["kelurahan"].value;
            var email = document.forms["formKaryawan"]["email"].value;
            var tlp1 = document.forms["formKaryawan"]["tlp1"].value;
            var tlp2 = document.forms["formKaryawan"]["tlp2"].value;
            var kota = document.forms["formKaryawan"]["kota"].value;
            var Pos = document.forms["formKaryawan"]["pos"].value;
            var tmpt = document.forms["formKaryawan"]["tempat"].value;
            var norek = document.forms["formKaryawan"]["norek"].value;
            var tenagakerja = document.forms["formKaryawan"]["tenagakerja"].value;
            var ktp = document.forms["formKaryawan"]["ktp"].value;
            var npwp = document.forms["formKaryawan"]["npwp"].value;
            var nsim = document.forms["formKaryawan"]["nsim"].value;
            var kesehatan = document.forms["formKaryawan"]["kesehatan"].value;
            // kodisikan
            if (nama.length > 30) {
                alert("Nama MAXIMAL karakter 30");
                return false;
            } else if (alamat.length > 50) {
                alert("Alamat MAXIMAL alamat 50 karakter");
                return false;
            } else if (kelurahan.length > 50) {
                alert("Kelurahan MAXIMAL 50 karakter");
                return false;
            } else if (email.length > 30) {
                alert("Email MAXIMAL 30 karakter");
                return false;
            } else if (tlp1.length > 15) {
                alert("Telphone MAXIMAL 15 karakter");
                return false;
            } else if (tlp2.length > 15) {
                alert("Telphone MAXIMAL 15 karakter");
                return false;
            } else if (kota.length > 30) {
                alert("Kota MAXIMAL kota 30 karakter");
                return false;
            } else if (Pos.length > 5) {
                alert("Pos MAXIMAL kode Pos 5 karakter");
                return false;
            } else if (tmpt.length > 30) {
                alert("Tempat lahir MAXIMAL pos 30 karakter");
                return false;
            } else if (norek.length > 20) {
                alert("No.Rekening MAXIMAL pos 20 karakter");
                return false;
            } else if (tenagakerja.length > 20) {
                alert("Data BPJS tenaga kerja harus angka kk dan maximal datapun cuma 20 karakter");
                return false;
            } else if (ktp.length > 30) {
                alert("Data nomor KTP harus angka kk dan maximal datapun cuma 30 karakter");
                return false;
            } else if (npwp.length > 30) {
                alert("Data harus angka kk dan maximal datapun cuma 30 karakter");
                return false;
            } else if (nsim.length > 30) {
                alert("maximal nomor sim 30 karakter");
                return false;
            } else if (kesehatan.length > 20) {
                alert("MAXIMAL 20 karakter ya!!");
                return false;
            }

            }
            const ChangeDate = () => {
                $("#tglL").attr("type","date");
            }
            const ChangeDateMasuk = () => {
            $("#tglmasuk").attr("type","date");
            }
            const ChangeDateKeluar = () => {
            $("#tglkeluar").attr("type","date");
            }
            const ChangeDateAGaji = () => {
            $("#tglagaji").attr("type","date");
            }
            const ChangeDateEGaji = () => {
            $("#tglegaji").attr("type","date");
            }
            const ChangeDateSim = () => {
            $("#berlakuSIM").attr("type","date");
        }

</script>
    <!--content-->
<!--#include file="../../layout/footer.asp"-->