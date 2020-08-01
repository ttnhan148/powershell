$hostname = HOSTNAME.EXE
$NASIPAddress = "192.168.12.10"
Write-Host "----------Bat Dau Xoa-----"
$count=3                    
$DataFolderPath = "Recoding\$(((Get-Date).AddDays(-$count)).ToString('yyyy'))\$(((Get-Date).AddDays(-$count)).ToString('MM'))\$(((Get-Date).AddDays(-$count)).ToString('dd'))"
$PCFolder = "D:\$DataFolderPath"
$NASFolder = "\\$NASIpAddress\Actuator_Photo\$hostname\D\$DataFolderPath"

if ((Test-Path $PCFolder -PathType Container)){ #Check Folder co ton tai hay khong.
    $FolderSize = Get-ChildItem -path $PCFolder -recurse    
    if( $FolderSize.Length -le 1){             #Check Folder co trong hay khong.
      Write-Host $PCFolder "Folder khong co file"
      Remove-Item $PCFolder -Recurse.           #Xoa Folder Trong
    }  
    else{
        Get-ChildItem -Path $PCFolder -Recurse -Force -Name | 
        ForEach-Object {
        $filename =$_
        $NASfilePath = $NASFolder + "\$filename"
        $PCfilePath = $PCFolder + "\$filename"
                
        if ((Test-Path $NASfilePath -PathType Leaf)){    #Check File da duoc upload tren NAS chua.
            Write-Host $PCFilePath "Dang tien hanh xoa"
           # Remove-Item –path $PCfilePath                 #Xoa File
        }
        else{
            Write-Host $PCFilePath "Khong Tim Thay File, File chua duoc upload"
        }
        } 
    }
}  
else{
    Write-Host $PCFolder "Folder khong ton tai hoac Khong co file"
}