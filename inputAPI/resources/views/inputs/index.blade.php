<h1 align="center">List Upload </h1>
<table border="2" cellspacing="" align="center">
    <thead>
        <tr>
            <th>Nama_Kendaraan</th>
            <th>Jenis_Kendaraan</th>
            <th>Harga_Sewa</th>
        </tr>
    </thead>
    <tbody>
        <!-- perulangan untuk seluruh item yang ada di database syntax ala blade-->
        @foreach ($inputs as $input )
        <tr>
            <td>{{$input->nama_kendaraan}}</td>
            <td>{{$input->jenis_kendaraan}}</td>
            <td>{{$input->harga_sewa}}</td>
            <td>
                <a href="/inputs/{{$input->id}}/edit">Edit</a>
                <form action="/inputs/{{$input->id}}" method="post">
                    @method('DELETE');
                    @csrf
                    <input type="submit" value="Delete">
                </form>

            </td>


        </tr>
        @endforeach

    </tbody>
    <a href="/inputs/create"><b>Create</a>

</table>