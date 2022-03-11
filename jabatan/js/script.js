$(document).ready(function () {
  //button tambah
  $('#tombolTambah').on('click', function () {
    $('#id').attr('readonly', false);

    $('#formModalLabel').html('Tambah Data');
    $('.modal-footer button[type=submit]').html('Tambah');
    $('.modal-body form').attr('action', 'tambah.asp');
    $('#nama').html('');
    $('#id').val('');
    $('#nama').val('');

  });
  // input search
  $('#key').on('keyup', function () {
    var key = $('#key').val();
    if (key !== null) {
      $('.content').load('../jabatan/ajax/Carijabatan.asp?key=' + key);
    }
  });
});

function ubahAktif(e, a) {
  Swal.fire({
    title: 'Yakin Untuk Dirubah?',
    text: "Aktifasi Jabatan",
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