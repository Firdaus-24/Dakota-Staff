<!--#include file="../constend/constanta.asp"-->
<% 
nip = request.querystring("nip")
 %> 
<style>
    .contentDetail{
        background-color:#d3d3d3;
        padding:10px 10px;
        border-radius:5px;
        position:relative;
    }
    .accordion{
        display:none;
    }
    .tombol-template{
        
    }
    @media (max-width:540px) {
        .contentDetail{
            padding:10px 0 10px 0;
        }
        .accordion{
            display:block;
        }
        .tombol-template{
            display:none;
        }
        .accordion-body button{
            display:block;
            width:100%;
            text-transform:uppercase;
            font-family:"roboto";
            letter-spacing:2px;
        }
        #hello{
            margin-top:-3px;
            width:30px;
        }
    }
    @media (min-width: 30em) and (max-width: 50em){
        .contentDetail{
            padding:10px 0 10px 0;
        }
        .accordion{
            display:block;
        }
        .tombol-template{
            display:none;
        }
        .accordion-body button{
            display:block;
            width:100%;
            text-transform:uppercase;
            font-family:"roboto";
            letter-spacing:2px;
        }
        #hello{
            margin-top:-3px;
            width:30px;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col text-center text-uppercase mt-4 detail-kar">
            <h3>Detail Karyawan</h3>
        </div>
    </div>
    <div class='row'>
        <div class='col-sm-12'>
            <div class="accordion" id="accordionExample">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            <img src="<%= url %>/logo/hello.gif" id="hello">
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <button type="button" class="btn" name="biografi" id="biografi" onCLick="window.location.href='<%= url %>/detail-karyawan/index.asp?nip=<%= nip %> '">Biografi</button>
                            <button type="button" class="btn keluarga1" name="keluarga1" id="keluarga1" onCLick="window.location.href='<%= url %>/detail-karyawan/keluarga1.asp?nip=<%= nip %>'">Keluarga1</button>
                            <button type="button" class="btn keluarga2" name="keluarga2" id="keluarga2" onCLick="window.location.href='<%= url %>/detail-karyawan/keluarga2.asp?nip=<%= nip %>'">Keluarga2</button>
                            <button type="button" class="btn kesehatan" name="kesehatan" id="kesehatan" onCLick="window.location.href='<%= url %>/detail-karyawan/Kesehatan.asp?nip=<%= nip %>'">Kesehatan</button>
                            <button type="button" class="btn pendidikan-detail" name="pendidikan" id="pendidikan" onCLick="window.location.href='<%= url %>/detail-karyawan/pendidikan.asp?nip=<%=nip%>'" >Pendidikan</button>
                            <button type="button" class="btn" name="keterampilan" id="keterampilan">Keterampilan</button>
                            <button type="button" class="btn" name="Pekerjaan" id="Pekerjaan" onCLick="window.location.href='<%= url %>/detail-karyawan/pekerjaan.asp?nip=<%= nip %>'">Pekerjaan</button>
                            <% if session("HA7") = true then %>
                                <button type="button" class="btn penghasilan-detail" name="Penghasilan" id="Penghasilan" onCLick="window.location.href='<%= url %>/detail-karyawan/penghasilan.asp?nip=<%= nip %>'" >Penghasilan</button>
                            <% end if %>
                            <button type="button" class="btn" name="Catatan" id="Catatan" onCLick="window.location.href='<%= url %>/detail-karyawan/memo.asp?nip=<%= nip %>'">Catatan</button>
                            <button type="button" class="btn" name="status" id="status" onCLick="window.location.href='<%= url %>/detail-karyawan/status.asp?nip=<%= nip %>'">Status</button>
                            <button type="button" class="btn" name="mutasi" id="mutasi" onCLick="window.location.href='<%= url %>/detail-karyawan/mutasi.asp?nip=<%= nip %>'">Mutasi</button>
                            <button type="button" class="btn" name="cutiSakit" id="cutiSakit" onCLick="window.location.href='<%= url %>/detail-karyawan/cutiSakitIzin.asp?nip=<%= nip %>'">CutiIzinSakit</button>
                            <button type="button" class="btn absensi-detail" name="absensi" id="absensi" onCLick="window.location.href='<%= url %>/detail-karyawan/absensi.asp?nip=<%= nip %>'">Absensi</button>
                            <button type="button" class="btn" name="perjanjian" id="perjanjian" onCLick="window.location.href='<%= url %>/detail-karyawan/perjanjian.asp?nip=<%= nip %>'">Perjanjian</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row text-center tombol-template">
        <div class="col-lg-12"> 
        <!--tombol-->
            <div class="btn-group" role="group" aria-label="Basic example">
                <button type="button" class="btn btn-sm btn-outline-danger" name="biografi" id="biografi" onCLick="window.location.href='<%= url %>/detail-karyawan/index.asp?nip=<%= nip %> '">Biografi</button>
                <button type="button" class="btn btn-sm btn-outline-danger keluarga1" name="keluarga1" id="keluarga1" onCLick="window.location.href='<%= url %>/detail-karyawan/keluarga1.asp?nip=<%= nip %>'">Keluarga1</button>
                <button type="button" class="btn btn-sm btn-outline-danger keluarga2" name="keluarga2" id="keluarga2" onCLick="window.location.href='<%= url %>/detail-karyawan/keluarga2.asp?nip=<%= nip %>'">Keluarga2</button>
                <button type="button" class="btn btn-sm btn-outline-danger kesehatan" name="kesehatan" id="kesehatan" onCLick="window.location.href='<%= url %>/detail-karyawan/Kesehatan.asp?nip=<%= nip %>'">Kesehatan</button>
                <button type="button" class="btn btn-sm btn-outline-danger pendidikan-detail" name="pendidikan" id="pendidikan" onCLick="window.location.href='<%= url %>/detail-karyawan/pendidikan.asp?nip=<%=nip%>'" >Pendidikan</button>
                <button type="button" class="btn btn-sm btn-outline-danger" name="keterampilan" id="keterampilan">Keterampilan</button>
                <button type="button" class="btn btn-sm btn-outline-danger" name="Pekerjaan" id="Pekerjaan" onCLick="window.location.href='<%= url %>/detail-karyawan/pekerjaan.asp?nip=<%= nip %>'">Pekerjaan</button>
                <% if session("HA7")=true then %>
					<button type="button" class="btn btn-sm btn-outline-danger penghasilan-detail" name="Penghasilan" id="Penghasilan" onCLick="window.location.href='<%= url %>/detail-karyawan/penghasilan.asp?nip=<%= nip %>'" >Penghasilan</button>
				<% end if %>
                <button type="button" class="btn btn-sm btn-outline-danger" name="Catatan" id="Catatan" onCLick="window.location.href='<%= url %>/detail-karyawan/memo.asp?nip=<%= nip %>'">Catatan</button>
                <button type="button" class="btn btn-sm btn-outline-danger" name="status" id="status" onCLick="window.location.href='<%= url %>/detail-karyawan/status.asp?nip=<%= nip %>'">Status</button>
                <button type="button" class="btn btn-sm btn-outline-danger" name="mutasi" id="mutasi" onCLick="window.location.href='<%= url %>/detail-karyawan/mutasi.asp?nip=<%= nip %>'">Mutasi</button>
                <button type="button" class="btn btn-sm btn-outline-danger" name="cutiSakit" id="cutiSakit" onCLick="window.location.href='<%= url %>/detail-karyawan/cutiSakitIzin.asp?nip=<%= nip %>'">CutiIzinSakit</button>
                <button type="button" class="btn btn-sm btn-outline-danger absensi-detail" name="absensi" id="absensi" onCLick="window.location.href='<%= url %>/detail-karyawan/absensi.asp?nip=<%= nip %>'">Absensi</button>
                <button type="button" class="btn btn-sm btn-outline-danger" name="perjanjian" id="perjanjian" onCLick="window.location.href='<%= url %>/detail-karyawan/perjanjian.asp?nip=<%= nip %>'">Perjanjian</button>
            </div>
        </div>
    </div>
</div>

