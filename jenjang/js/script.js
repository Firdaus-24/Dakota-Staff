$(document).ready(function () {
    $('#keyJenjang').on('keyup', function () {
        var key = $('#keyJenjang').val();
        $('.tableJenjang').load('ajax/CariJenjang.asp?key=' + key);
    });
    $('#tombolTambah').on('click', function () {

        $('#formModalLabel').html('Tambah Data');
        $('.modal-footer button[type=submit]').html('Tambah');
        $('.modal-body form').attr('action', 'tambah.asp');
        $('#nama').html('');
        $('#id').val('');
        $('#nama').val('');

    });
});

function ubahJenjang(id, nama) {
    $('#formModalLabel').html('UPDATE DATA');
    $('.modal-footer button[type=submit]').html('UPDATE');
    $('.modal-body form').attr('action', 'update.asp?code=' + id);
    $('#id').val(id);
    $('#nama').val(nama);
}

function ubahAktif(e, a) {
    Swal.fire({
        title: 'Yakin Untuk Dirubah?',
        text: "Aktifasi Jenjang",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes'
    }).then((result) => {
        if (result.isConfirmed) {
            $.post("aktifId.asp", {
                code: e,
                aktif: a
            }, function (data, status) {
                location.reload();
            });
        }
    });
}