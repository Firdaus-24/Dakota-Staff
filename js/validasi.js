// validasi shiftkerja
function shiftadd() {
    // cari data
    var shift = document.forms["formshift"]["shiftName"];
    var divisi = document.forms["formshift"]["karyawan"];

    var checked = false;

    for (var i = 0; i < divisi.length; i++) {
        // console.log(i);
        if (divisi[i].checked) {
            checked = true;
        }
    }
    if (!checked) {
        alert('Pilih Salah Satu');
        return checked;
    }
    if (shift.selectedIndex < 1) {
        alert('Pilih shift dulu ya');
        return false;
    }
}
