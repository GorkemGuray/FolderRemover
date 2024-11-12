# Script parametreleri
$FolderPath = "C:\OMRON\Soft-NA\Storage\SDCARD\OperationLog\test"  # Ana klasor yolu
$DaysOld = 30                         # Silinecek klasorlerin yasi

# Hata yakalama blogu
try {
    # Klasor yolunun gecerli olup olmadigini kontrol et
    if (-not (Test-Path -Path $FolderPath)) {
        throw "Belirtilen klasor yolu bulunamadi: $FolderPath"
    }

    # Gunun tarihini al
    $CurrentDate = Get-Date

    # yyyyMMdd formatindaki klasorleri bul
    $Folders = Get-ChildItem -Path $FolderPath -Directory |
        Where-Object { $_.Name -match '^\d{8}$' } |
        ForEach-Object {
            $FolderDate = [datetime]::ParseExact($_.Name, 'yyyyMMdd', $null)
            @{
                Folder = $_
                Date = $FolderDate
                DaysDiff = ($CurrentDate - $FolderDate).Days
            }
        }

    # Belirtilen gunden eski klasorleri filtrele
    $OldFolders = $Folders | Where-Object { $_.DaysDiff -gt $DaysOld }

    # Sonuclari goster
    Write-Host "Islem yapilacak klasor: $FolderPath"
    Write-Host "Silinecek klasor yasi: $DaysOld gun ve uzeri"
    Write-Host "Toplam klasor sayisi: $($Folders.Count)"
    Write-Host "$DaysOld gunden eski klasor sayisi: $($OldFolders.Count)"
    
    # Eski klasor kontrolu
    if ($OldFolders.Count -eq 0) {
        Write-Host "`n$DaysOld gunden eski klasor bulunmamaktadir."
        Write-Host "Program sonlandiriliyor..."
        exit
    }

    # Silinen klasor sayisini takip etmek icin sayac
    $DeletedCount = 0

    # Silinecek klasorleri listele ve sil
    Write-Host "`nSilinecek klasorler:"
    Write-Host "--------------------"
    foreach ($Item in $OldFolders) {
        try {
            Write-Host "Siliniyor: $($Item.Folder.Name) | Yasi: $($Item.DaysDiff) gun | Olusturma Tarihi: $($Item.Date.ToString('yyyy-MM-dd'))"
            Remove-Item -Path $Item.Folder.FullName -Force -Recurse
            Write-Host "Basarili: $($Item.Folder.Name) silindi"
            $DeletedCount++
        }
        catch {
            Write-Warning "Hata: $($Item.Folder.Name) silinemedi - $_"
        }
    }
    
    Write-Host "`nIslem tamamlandi."
    Write-Host "Toplam $DeletedCount klasor silindi."
}
catch {
    Write-Error "Bir hata olustu: $_"
}
