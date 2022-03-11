<!-- #include file='../../connection.asp' -->
<% 
nama = trim(Request.form("nama"))
nip = trim(Request.form("nip"))

nama1 = trim(Request.form("nama1"))
nip1 = trim(Request.form("nip1"))

' filter atasan satu
if nama <> "" then
    filternama = " AND Kry_Nama LIKE '%"& nama &"%'"
end if

if nip <> "" then
    filterNip = " AND Kry_Nip = '"& nip &"'"
end If 
' filer atasan 2
if nama1 <> "" then
    filternama1 = " AND Kry_Nama LIKE '%"& nama1 &"%'"
end if

if nip1 <> "" then
    filterNip1 = " AND Kry_Nip = '"& nip1 &"'"
end If 

set atasan_cmd = Server.CreateObject("ADODB.Command")
atasan_cmd.activeConnection = MM_Cargo_string

    if nama <> "" or nip <> "" then
        atasan_cmd.commandText = "SELECT Kry_Nip, Kry_Nama FROM HRD_M_Karyawan WHERE Kry_AktifYN = 'Y' AND Kry_Nip NOT LIKE '%H%' AND Kry_Nip NOT LIKE 'A' "& filternama &" "& filterNip &" ORDER BY Kry_Nama ASC"
        ' Response.Write atasan_cmd.commandTExt & "<br>"
        set atasan = atasan_cmd.execute 
    if not atasan.eof then
 %>
<div class='row ajaxAtasan' style="height:10em;">
    <div class='col-3'>
        <table class="table" style="font-size:10px;width:19em;white-space: nowrap;">
            <thead>
                <tr>
                <th scope="col">Pilih</th>
                <th scope="col">Nip</th>
                <th scope="col">Nama</th>
                </tr>
            </thead>
            <tbody>
            <% do while not atasan.eof %>
                <tr>
                    <th scope="row"><input class="form-check-input" type="radio" name="radioNip" id="radioNip" value="<%= atasan("Kry_nip") %>"  onchange="return getRadio(this.value)"></th>
                    <td><%= atasan("Kry_Nip") %></td>
                    <td><%= atasan("Kry_Nama") %></td>
                </tr>
            <% 
                atasan.movenext
                loop
            %>
            </tbody>
        </table>
    </div>
</div>
    <% else %>
    <div class='row ajaxAtasan mt-3 text-center'>
        <div class='col'>
            <p><b>DATA TIDAK DITEMUKAN</b></p>
        </div>
    </div>
    <% end if %>
<% end if %>
<% 
    if nama1 <> "" or nip1 <> "" then
        atasan_cmd.commandText = "SELECT Kry_Nip, Kry_Nama FROM HRD_M_Karyawan WHERE Kry_AktifYN = 'Y' AND Kry_Nip NOT LIKE '%H%' AND Kry_Nip NOT LIKE 'A' "& filternama1 &" "& filterNip1 &" ORDER BY Kry_Nama ASC"
        ' Response.Write atasan_cmd.commandTExt & "<br>"
        set atasan = atasan_cmd.execute 
 
    if not atasan.eof then
 %>
<div class='row ajaxAtasan' style="height:10em;">
    <div class='col-3'>
        <table class="table" style="font-size:10px;width:19em;white-space: nowrap;">
            <thead>
                <tr>
                <th scope="col">Pilih</th>
                <th scope="col">Nip</th>
                <th scope="col">Nama</th>
                </tr>
            </thead>
            <tbody>
            <% do while not atasan.eof %>
                <tr>
                    <th scope="row"><input class="form-check-input" type="radio" name="radioNip" id="radioNip" value="<%= atasan("Kry_nip") %>"  onchange="return getRadio1(this.value)"></th>
                    <td><%= atasan("Kry_Nip") %></td>
                    <td><%= atasan("Kry_Nama") %></td>
                </tr>
            <% 
                atasan.movenext
                loop
            %>
            </tbody>
        </table>
    </div>
</div>
    <% else %>
    <div class='row ajaxAtasan mt-3 text-center'>
        <div class='col'>
            <p><b>DATA TIDAK DITEMUKAN</b></p>
        </div>
    </div>
    <% end if %>
<% end if %>
<script>
function getRadio(e){
    this.plagRadio = e;
    const atasanPertama = (this.plagRadio != "") ? $("#atasan").val(this.plagRadio) :  $("#atasan").val("");
    $(".ajaxAtasan").hide();
}
function getRadio1(e){
    this.plagRadio = e;
    const atasanPertama = (this.plagRadio != "") ? $("#atasanUpper").val(this.plagRadio) :  $("#atasanUpper").val("");
    $(".ajaxAtasan").hide();
}
</script>