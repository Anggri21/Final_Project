<h1>Edit</h1>
<form action="/inputs/{{$input->id}}" method="POST">
    <!-- karena mau edit maka kita perlu nambahin method PUT -->
    @method('PUT')
    @csrf
    <!-- valu dalam kurung kurawal disini fungsinya ngambil data dari data yang ingin diedit supaya bisa ditampilkan memlalui $input yang udah dibuat tadi di controller -->
    nama_kendaraan : <input type="text" name="nama_kendaraan" value="{{ $input->nama_kendaraan}}"><br>
    jenis_kendaraan : <input type="text" name="jenis_kendaraan" value="{{ $input->jenis_kendaraan}}"><br>
    harga_sewa: <input type="text" name="harga" value="{{ $input->harga}}"><br>

    <input type="submit" value="Edit">
</form>