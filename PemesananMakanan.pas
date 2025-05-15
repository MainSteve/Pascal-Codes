program PemesananMakanan;

uses
  SysUtils; // Add this unit for the Format function

const
  MAX_MENU = 5;
  MAX_PESANAN = 50; // Maksimum jenis pesanan yang berbeda

type
  TMenu = record
    Nama: string;
    Harga: real;
  end;
  
  TPesanan = record
    MenuIndex: integer; // Indeks menu yang dipesan
    Jumlah: integer;    // Jumlah yang dipesan
    SubTotal: real;     // Subtotal untuk pesanan ini
  end;

var
  Menu: array[1..MAX_MENU] of TMenu;
  Pesanan: array[1..MAX_PESANAN] of TPesanan; // Array untuk menyimpan daftar pesanan
  JumlahPesanan: integer; // Jumlah jenis pesanan yang dilakukan
  Pilihan, Jumlah, UbahIndex, JumlahBaru: integer;
  TotalHarga, SubTotal: real;
  Lanjut, PilihMenu: char;
  i, j, MenuTersedia: integer; // Variabel untuk loop dan cek menu

begin
  { Inisialisasi daftar menu }
  Menu[1].Nama := 'Nasi Goreng'; Menu[1].Harga := 15000;
  Menu[2].Nama := 'Mie Goreng'; Menu[2].Harga := 13000;
  Menu[3].Nama := 'Ayam Bakar'; Menu[3].Harga := 20000;
  Menu[4].Nama := 'Sate Ayam'; Menu[4].Harga := 18000;
  Menu[5].Nama := 'Es Teh Manis'; Menu[5].Harga := 5000;

  TotalHarga := 0;
  JumlahPesanan := 0; // Inisialisasi jumlah pesanan
  PilihMenu := 'y';   // Mulai dengan menampilkan menu

  repeat
    { Tampilkan daftar menu jika diinginkan }
    if (PilihMenu = 'y') or (PilihMenu = 'Y') then
    begin
      writeln('Daftar Menu:');
      writeln('-----------------------------------');
      for Pilihan := 1 to MAX_MENU do
        writeln(Pilihan, '. ', Menu[Pilihan].Nama, ' - Rp.', Format('%.0n', [Menu[Pilihan].Harga]));
      writeln('-----------------------------------');

      { Memilih menu }
      write('Pilih nomor menu yang ingin dipesan (1-', MAX_MENU, '): ');
      readln(Pilihan);

      if (Pilihan < 1) or (Pilihan > MAX_MENU) then
      begin
        writeln();
        writeln('=======================================');
        writeln('Pilihan tidak valid. Pilih angka 1-5.');
        writeln('=======================================');
        writeln();
        continue;
      end;

      { Memasukkan jumlah pesanan }
      write('Masukkan jumlah pesanan untuk ', Menu[Pilihan].Nama, ': ');
      readln(Jumlah);

      { Menghitung subtotal }
      SubTotal := Menu[Pilihan].Harga * Jumlah;
      
      { Cek apakah menu ini sudah pernah dipesan sebelumnya }
      MenuTersedia := 0;
      for i := 1 to JumlahPesanan do
      begin
        if Pesanan[i].MenuIndex = Pilihan then
        begin
          MenuTersedia := i;
          break;
        end;
      end;

      { Jika menu sudah ada, update jumlah dan subtotal }
      if MenuTersedia > 0 then
      begin
        Pesanan[MenuTersedia].Jumlah := Pesanan[MenuTersedia].Jumlah + Jumlah;
        Pesanan[MenuTersedia].SubTotal := Pesanan[MenuTersedia].SubTotal + SubTotal;
      end
      { Jika menu belum ada, tambahkan sebagai pesanan baru }
      else
      begin
        JumlahPesanan := JumlahPesanan + 1;
        Pesanan[JumlahPesanan].MenuIndex := Pilihan;
        Pesanan[JumlahPesanan].Jumlah := Jumlah;
        Pesanan[JumlahPesanan].SubTotal := SubTotal;
      end;

      { Update total harga }
      TotalHarga := TotalHarga + SubTotal;

      writeln('Subtotal untuk ', Menu[Pilihan].Nama, ': Rp.', Format('%.0n', [SubTotal]));
      writeln('Total sementara: Rp.', Format('%.0n', [TotalHarga]));
      writeln();
      
      PilihMenu := 'n'; // Reset ke tidak memilih menu
    end;

    { Menampilkan pesanan saat ini }
    if JumlahPesanan > 0 then
    begin
      writeln('Pesanan Anda saat ini:');
      writeln('------------------------------------------');
      for i := 1 to JumlahPesanan do
      begin
        writeln(
          i, '. ', 
          Menu[Pesanan[i].MenuIndex].Nama, ' x', 
          Pesanan[i].Jumlah, ' = Rp.', 
          Format('%.0n', [Pesanan[i].SubTotal])
        );
      end;
      writeln('------------------------------------------');
    end
    else
    begin
      writeln('Belum ada pesanan.');
    end;

    { Menanyakan apakah ingin memesan lagi atau mengubah pesanan }
    writeln('Pilihan:');
    writeln('y - Pesan menu lain');
    writeln('u - Ubah jumlah atau hapus pesanan');
    writeln('n - Selesai dan bayar');
    write('Pilihan Anda (y/u/n): ');
    readln(Lanjut);
    
    { Jika ingin mengubah pesanan }
    if (Lanjut = 'u') or (Lanjut = 'U') then
    begin
      if JumlahPesanan = 0 then
      begin
        writeln('Belum ada pesanan untuk diubah.');
        continue;
      end;
      
      write('Masukkan nomor pesanan yang ingin diubah (1-', JumlahPesanan, '): ');
      readln(UbahIndex);
      
      if (UbahIndex < 1) or (UbahIndex > JumlahPesanan) then
      begin
        writeln('Nomor pesanan tidak valid.');
        continue;
      end;
      
      write('Masukkan jumlah baru untuk ', Menu[Pesanan[UbahIndex].MenuIndex].Nama, ' (0 untuk hapus): ');
      readln(JumlahBaru);
      
      { Hitung perubahan pada total }
      TotalHarga := TotalHarga - Pesanan[UbahIndex].SubTotal; // Kurangi subtotal lama
      
      if JumlahBaru = 0 then
      begin
        { Hapus pesanan dengan menggeser array }
        for j := UbahIndex to JumlahPesanan - 1 do
        begin
          Pesanan[j] := Pesanan[j + 1];
        end;
        JumlahPesanan := JumlahPesanan - 1;
        writeln('Pesanan dihapus.');
      end
      else
      begin
        { Update jumlah dan subtotal }
        Pesanan[UbahIndex].Jumlah := JumlahBaru;
        Pesanan[UbahIndex].SubTotal := Menu[Pesanan[UbahIndex].MenuIndex].Harga * JumlahBaru;
        TotalHarga := TotalHarga + Pesanan[UbahIndex].SubTotal; // Tambah subtotal baru
        writeln('Pesanan diperbarui.');
      end;
      
      writeln('Total setelah perubahan: Rp.', Format('%.0n', [TotalHarga]));
      writeln();
      
      { Tetap di menu ubah pesanan (tidak kembali ke daftar menu) }
      PilihMenu := 'n';
      Lanjut := 'u';
    end
    else if (Lanjut = 'y') or (Lanjut = 'Y') then
    begin
      { Kembali ke menu pemesanan }
      PilihMenu := 'y';
    end;
    
  until (Lanjut = 'n') or (Lanjut = 'N');

  { Menampilkan struk pesanan }
  writeln;
  writeln('============= STRUK PESANAN =============');
  writeln('No  Item             Jumlah    Harga      Subtotal');
  writeln('------------------------------------------');
  for i := 1 to JumlahPesanan do
  begin
    writeln(
      Format('%-3d', [i]), ' ',
      Format('%-16s', [Menu[Pesanan[i].MenuIndex].Nama]), ' ',
      Format('%-8d', [Pesanan[i].Jumlah]), ' ',
      Format('Rp.%-9.0n', [Menu[Pesanan[i].MenuIndex].Harga]), ' ',
      Format('Rp.%.0n', [Pesanan[i].SubTotal])
    );
  end;
  writeln('------------------------------------------');
  writeln('Total yang harus dibayar: Rp.', Format('%.0n', [TotalHarga]));
  writeln('=========== TERIMA KASIH ===========');
  writeln('Silakan datang kembali!');
  readln;
end.