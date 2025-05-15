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
  Pilihan, Jumlah: integer;
  TotalHarga, SubTotal: real;
  Lanjut: char;
  i: integer; // Variabel untuk loop

begin
  { Inisialisasi daftar menu }
  Menu[1].Nama := 'Nasi Goreng'; Menu[1].Harga := 15000;
  Menu[2].Nama := 'Mie Goreng'; Menu[2].Harga := 13000;
  Menu[3].Nama := 'Ayam Bakar'; Menu[3].Harga := 20000;
  Menu[4].Nama := 'Sate Ayam'; Menu[4].Harga := 18000;
  Menu[5].Nama := 'Es Teh Manis'; Menu[5].Harga := 5000;

  TotalHarga := 0;
  JumlahPesanan := 0; // Inisialisasi jumlah pesanan

  repeat
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

    { Menghitung subtotal dan total harga }
    SubTotal := Menu[Pilihan].Harga * Jumlah;
    TotalHarga := TotalHarga + SubTotal;

    { Menyimpan pesanan ke dalam array }
    JumlahPesanan := JumlahPesanan + 1;
    Pesanan[JumlahPesanan].MenuIndex := Pilihan;
    Pesanan[JumlahPesanan].Jumlah := Jumlah;
    Pesanan[JumlahPesanan].SubTotal := SubTotal;

    writeln('Subtotal untuk ', Menu[Pilihan].Nama, ': Rp.', Format('%.0n', [SubTotal]));
    writeln('Total sementara: Rp.', Format('%.0n', [TotalHarga]));

    { Menanyakan apakah ingin memesan lagi }
    write('Apakah Anda ingin memesan menu lain? (y/n): ');
    readln(Lanjut);
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